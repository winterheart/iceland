# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/busybox/busybox-1.15.3.ebuild,v 1.2 2009/12/28 22:33:28 solar Exp $

inherit eutils flag-o-matic savedconfig toolchain-funcs

################################################################################
# BUSYBOX ALTERNATE CONFIG MINI-HOWTO
#
# Busybox can be modified in many different ways. Here's a few ways to do it:
#
# (1) Emerge busybox with FEATURES=keepwork so the work directory won't
#     get erased afterwards. Add a definition like ROOT=/my/root/path to the
#     start of the line if you're installing to somewhere else than the root
#     directory. This command will save the default configuration to
#     ${PORTAGE_CONFIGROOT} (or ${ROOT} if ${PORTAGE_CONFIGROOT} is not
#     defined), and it will tell you that it has done this. Note the location
#     where the config file was saved.
#
#     FEATURES=keepwork USE=savedconfig emerge busybox
#
# (2) Go to the work directory and change the configuration of busybox using its
#     menuconfig feature.
#
#     cd /var/tmp/portage/busybox*/work/busybox-*
#     make menuconfig
#
# (3) Save your configuration to the default location and copy it to the
#     one of the locations listed in /usr/portage/eclass/savedconfig.eclass
#
# (4) Emerge busybox with USE=savedconfig to use the configuration file you
#     just generated.
#
################################################################################
#
# (1) Alternatively skip the above steps and simply emerge busybox without
#     USE=savedconfig.
#
# (2) Edit the file it saves by hand. ${ROOT}"/etc/portage/savedconfig/${CATEGORY}/${PF}
#
# (3) Remerge busybox as using USE=savedconfig.
#
################################################################################

#SNAPSHOT=20040726
SNAPSHOT=""

DESCRIPTION="Utilities for rescue and embedded systems"
HOMEPAGE="http://www.busybox.net/"
if [[ -n ${SNAPSHOT} ]] ; then
	MY_P=${PN}
	SRC_URI="http://www.busybox.net/downloads/snapshots/${PN}-${SNAPSHOT}.tar.bz2"
else
	MY_P=${PN}-${PV/_/-}
	SRC_URI="http://www.busybox.net/downloads/${MY_P}.tar.bz2"
fi
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="debug make-symlinks pam selinux static"
RESTRICT="test"

DEPEND="selinux? ( sys-libs/libselinux )
	pam? ( sys-libs/pam )"

S=${WORKDIR}/${MY_P}

busybox_config_option() {
	case $1 in
		y) sed -i -e "s:.*CONFIG_$2.*set:CONFIG_$2=y:g" .config;;
		n) sed -i -e "s:CONFIG_$2=y:# CONFIG_$2 is not set:g" .config;;
		*) use $1 \
		       && busybox_config_option y $2 \
		       || busybox_config_option n $2
		   return 0
		   ;;
	esac
	einfo $(grep "CONFIG_$2[= ]" .config || echo Could not find CONFIG_$2 ...)
}

src_unpack() {
	unset KBUILD_OUTPUT #88088

	unpack ${MY_P}.tar.bz2
	cd "${S}"

	# patches go here!
	epatch "${FILESDIR}"/busybox-1.15.2-bb.patch
	#epatch "${FILESDIR}"/busybox-${PV}-*.patch
	epatch "${FILESDIR}"/${P}-jffs-fix.patch

	# work around broken ass powerpc compilers
	use ppc64 && append-flags -mminimal-toc
	# flag cleanup
	sed -i -r \
		-e 's:[[:space:]]?-(Werror|Os|falign-(functions|jumps|loops|labels)=1|fomit-frame-pointer)\>::g' \
		Makefile.flags || die
	#sed -i '/bbsh/s:^//::' include/applets.h
	sed -i '/^#error Aborting compilation./d' applets/applets.c || die
	use elibc_glibc && sed -i 's:-Wl,--gc-sections::' Makefile
	sed -i \
		-e "/^CROSS_COMPILE/s:=.*:= ${CHOST}-:" \
		-e "/^HOSTCC/s:=.*:= $(tc-getBUILD_CC):" \
		Makefile || die

	# check for a busybox config before making one of our own.
	# if one exist lets return and use it.

	restore_config .config
	if [ -f .config ]; then
		yes "" | emake -j1 oldconfig > /dev/null
		return 0
	else
		ewarn "Could not locate user configfile, so we will save a default one"
	fi

	# setup the config file
	emake -j1 allyesconfig > /dev/null
	busybox_config_option n DMALLOC
	busybox_config_option n FEATURE_SUID_CONFIG
	busybox_config_option n BUILD_AT_ONCE
	busybox_config_option n BUILD_LIBBUSYBOX
	busybox_config_option n NOMMU
	busybox_config_option n MONOTONIC_SYSCALL

	# If these are not set and we are using a uclibc/busybox setup
	# all calls to system() will fail.
	busybox_config_option y FEATURE_SH_IS_ASH
	busybox_config_option n FEATURE_SH_IS_NONE

	if use static && use pam ; then
		ewarn "You cannot have USE='static pam'.  Assuming static is more important."
	fi
	use static \
		&& busybox_config_option n PAM \
		|| busybox_config_option pam PAM
	busybox_config_option static STATIC
	busybox_config_option debug DEBUG
	use debug \
		&& busybox_config_option y NO_DEBUG_LIB \
		&& busybox_config_option n DMALLOC \
		&& busybox_config_option n EFENCE

	busybox_config_option selinux SELINUX

	# default a bunch of uncommon options to off
	local opt
	for opt in \
		CRONTAB \
		DC DEVFSD DNSD DPKG \
		FAKEIDENTD FBSPLASH FOLD FTP{GET,PUT} \
		HOSTID HUSH \
		INETD INOTIFYD IPCALC \
		LASH LOCALE_SUPPORT LOGNAME LPD \
		MSH \
		OD \
		SLATTACH SULOGIN \
		TASKSET TCPSVD \
		RPM RPM2CPIO \
		UDPSVD UUDECODE UUENCODE
	do
		busybox_config_option n ${opt}
	done

	emake -j1 oldconfig > /dev/null
}

src_compile() {
	unset KBUILD_OUTPUT #88088
	export SKIP_STRIP=y

	emake busybox || die "build failed"
	if ! use static && ! use pam ; then
		mv busybox_unstripped{,.bak}
		emake CONFIG_STATIC=y busybox || die "static build failed"
		mv busybox_unstripped bb
		mv busybox_unstripped{.bak,}
	fi
}

src_install() {
	unset KBUILD_OUTPUT #88088
	save_config .config

	into /
	newbin busybox_unstripped busybox || die
	if use static || use pam ; then
		dosym busybox /bin/bb || die
		dosym bb /bin/busybox.static || die
	else
		dobin bb || die
	fi
	dosym /bin/bb /sbin/mdev

	insinto /$(get_libdir)/rcscripts/addons
	doins "${FILESDIR}"/mdev-start.sh || die

	# bundle up the symlink files for use later
	emake install || die
	rm _install/bin/busybox
	tar cf busybox-links.tar -C _install . || : #;die
	insinto /usr/share/${PN}
	doins busybox-links.tar || die
	newins .config ${PF}.config || die

	dodoc AUTHORS README TODO

	cd docs || die
	docinto txt
	dodoc *.txt
	docinto pod
	dodoc *.pod
	dohtml *.html *.sgml

	cd ../examples || die
	docinto examples
	dodoc inittab depmod.pl *.conf *.script undeb unrpm

	cd bootfloppy || die
	docinto bootfloppy
	dodoc $(find . -type f)
}

pkg_preinst() {
	if use make-symlinks && [[ ! ${VERY_BRAVE_OR_VERY_DUMB} == "yes" ]] && [[ ${ROOT} == "/" ]] ; then
		ewarn "setting USE=make-symlinks and emerging to / is very dangerous."
		ewarn "it WILL overwrite lots of system programs like: ls bash awk grep (bug 60805 for full list)."
		ewarn "If you are creating a binary only and not merging this is probably ok."
		ewarn "set env VERY_BRAVE_OR_VERY_DUMB=yes if this is realy what you want."
		die "silly options will destroy your system"
	fi

	if use make-symlinks ; then
		mv "${D}"/usr/share/${PN}/busybox-links.tar "${T}"/ || die
	fi
}

pkg_postinst() {
	if use make-symlinks ; then
		cd "${T}" || die
		mkdir _install
		tar xf busybox-links.tar -C _install || die
		cp -vpPR _install/* "${ROOT}"/ || die "copying links for ${x} failed"
	fi

	echo
	einfo "This ebuild has support for user defined configs"
	einfo "Please read this ebuild for more details and re-emerge as needed"
	einfo "if you want to add or remove functionality for ${PN}"
	echo
}
