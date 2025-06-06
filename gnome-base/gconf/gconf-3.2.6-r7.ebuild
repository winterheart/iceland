# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GNOME_ORG_MODULE="GConf"
PYTHON_COMPAT=( python3_{10..13} )
PYTHON_REQ_USE="xml(+)"

inherit autotools gnome2 multilib-minimal python-single-r1

DESCRIPTION="GNOME configuration system and daemon"
HOMEPAGE="https://projects.gnome.org/gconf/"

LICENSE="LGPL-2+"
SLOT="2"
KEYWORDS="~alpha amd64 arm arm64 ~loong ~mips ppc ppc64 ~riscv sparc x86 ~x86-linux"
IUSE="debug +introspection ldap policykit"

RDEPEND="
	${PYTHON_DEPS}
	>=dev-libs/glib-2.34.3:2[${MULTILIB_USEDEP}]
	>=dev-libs/dbus-glib-0.100.2:=[${MULTILIB_USEDEP}]
	>=sys-apps/dbus-1.6.18-r1:=[${MULTILIB_USEDEP}]
	>=dev-libs/libxml2-2.9.1-r4:2[${MULTILIB_USEDEP}]
	introspection? ( >=dev-libs/gobject-introspection-0.9.5:= )
	ldap? ( >=net-nds/openldap-2.4.38-r1:=[${MULTILIB_USEDEP}] )
	policykit? ( sys-auth/polkit:= )
"
DEPEND="${RDEPEND}
	dev-build/gtk-doc-am
	dev-libs/libxslt
	dev-util/glib-utils
	>=dev-util/intltool-0.35
	virtual/pkgconfig
"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

PATCHES=(
	# Do not start gconfd when installing schemas, fix bug #238276, upstream #631983
	"${FILESDIR}/${PN}-2.24.0-no-gconfd.patch"
	# Do not crash in gconf_entry_set_value() when entry pointer is NULL, upstream #631985
	"${FILESDIR}/${PN}-2.28.0-entry-set-value-sigsegv.patch"
	# mconvert: enable recursive scheme lookup and fix a crasher
	"${FILESDIR}/${P}-mconvert-crasher.patch"
	# dbus: Don't spew to console when unable to connect to dbus daemon
	"${FILESDIR}/${P}-spew-console-error.patch"
	# gsettings-data-convert: Warn (and fix) invalid schema paths
	"${FILESDIR}/${P}-gsettings-data-convert-paths.patch"
	# gsettings-data-convert: Migrate from Python 2 to 3.
	"${FILESDIR}/${P}-python3.patch"
)

pkg_setup() {
	kill_gconf
	python-single-r1_pkg_setup
}

src_prepare() {
	default
	sed -i -e ":examples:d" configure.ac || die
	sed -i -e "s:examples::g" Makefile.am || die
	eautoreconf
}

multilib_src_configure() {
	ECONF_SOURCE=${S} \
	gnome2_src_configure \
		--disable-static \
		--enable-gsettings-backend \
		--with-gtk=3.0 \
		--disable-orbit \
		$(use_enable debug) \
		$(multilib_native_use_enable introspection) \
		$(use_with ldap openldap) \
		$(multilib_native_use_enable policykit defaults-service)

	if multilib_is_native_abi; then
		ln -s "${S}"/doc/gconf/html doc/gconf/html || die
	fi
}

multilib_src_install() {
	gnome2_src_install
}

multilib_src_install_all() {
	python_fix_shebang "${ED}"/usr/bin/gsettings-schema-convert

	keepdir /etc/gconf/gconf.xml.mandatory
	keepdir /etc/gconf/gconf.xml.defaults
	# Make sure this directory exists, bug #268070, upstream #572027
	keepdir /etc/gconf/gconf.xml.system

	echo "CONFIG_PROTECT_MASK=\"/etc/gconf\"" > 50gconf
	echo 'GSETTINGS_BACKEND="gconf"' >> 50gconf
	doenvd 50gconf
	dodir /root/.gconfd
}

pkg_preinst() {
	kill_gconf
	gnome2_pkg_preinst
}

pkg_postinst() {
	kill_gconf

	gnome2_pkg_postinst

	multilib_pkg_postinst() {
		gnome2_giomodule_cache_update \
			|| die "Update GIO modules cache failed (for ${ABI})"
	}
	multilib_foreach_abi multilib_pkg_postinst

	# change the permissions to avoid some gconf bugs
	einfo "changing permissions for gconf dirs"
	find  "${EPREFIX}"/etc/gconf/ -type d -exec chmod ugo+rx "{}" \;

	einfo "changing permissions for gconf files"
	find  "${EPREFIX}"/etc/gconf/ -type f -exec chmod ugo+r "{}" \;
}

pkg_postrm() {
	gnome2_pkg_postrm

	multilib_pkg_postrm() {
		gnome2_giomodule_cache_update \
			|| die "Update GIO modules cache failed (for ${ABI})"
	}
	multilib_foreach_abi multilib_pkg_postrm
}

kill_gconf() {
	# Avoid harmless error message. See bug #523868.
	mkdir -p "${HOME}"/.config || die

	# This function will kill all running gconfd-2 that could be causing troubles
	if [ -x "${EPREFIX}"/usr/bin/gconftool-2 ]
	then
		"${EPREFIX}"/usr/bin/gconftool-2 --shutdown
	fi

	return 0
}
