# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# Ebuild generated by g-pypi 0.2.1 (rev. 204)

EAPI="3"

inherit distutils eutils multilib webapp

DESCRIPTION="A platform for distributed translation submissions"
HOMEPAGE="http://www.transifex.org/"
SRC_URI="mirror://pypi/t/transifex/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"

IUSE="doc mysql sqlite postgres subversion"
DEPEND="dev-python/setuptools
	dev-python/django[mysql?,sqlite?,postgres?]
	>=dev-python/sphinx-0.4.2"

# spinx is really useless unless USE="doc", I will fix it later
# django-contact-form - hg 97559a887345 or newer
# django only 1.1
RDEPEND=">=dev-python/django-1.1
	dev-python/django-ajax-selects
	dev-python/django-authority
	=dev-python/django-contact-form-9999
	>=dev-python/django-filter-0.1
	>=dev-python/django-notification-0.1.2
	>=dev-python/django-pagination-1.0.5
	dev-python/django-piston
	dev-python/django-profile
	>=dev-python/django-sorting-0.1
	dev-python/django-staticfiles
	>=dev-python/django-tagging-0.3
	>=dev-python/django-threadedcomments-0.9
	dev-python/httplib2
	>=dev-python/imaging-1.1.6
	dev-python/markdown
	>=dev-python/polib-0.5.1
	>=dev-python/pygments-0.9
	dev-python/pygooglechart
	dev-python/simplejson
	>=dev-python/south-0.7
	dev-python/urlgrabber
	sys-devel/gettext
	subversion? ( dev-python/pysvn )"

WEBAPP_MANUAL_SLOT="yes"

src_prepare() {
	TX_HOME="/usr/$(get_libdir)/python$(python_get_version)/site-packages/${PN}/"
#	echo "CONFIG_PROTECT=\"${TX_HOME}/settings\"" > "${T}/50${PN}" || die
	sed -i -e \
		"s:os.path.dirname(__file__), 'settings':'/etc/${PN}/':" \
		transifex/settings.py || die "sed failed"
	epatch "${FILESDIR}"/${P}-0001_initial.py.patch
	epatch "${FILESDIR}"/${P}-0002_superuser-creation.patch
}

src_compile() {
	distutils_src_compile

	if use doc; then
		cd docs
		PYTHONPATH=.. emake SPHINXBUILD=sphinx-build html \
			|| die "emake html failed"
	fi
}

src_install() {
	distutils_src_install

	fperms 0755	${TX_HOME}/manage.py

	# There should be fperm for properly saving
	keepdir /var/lib/transifex/scratchdir
	dodir /var/lib/transifex/scratchdir/{msgmerge_files,sources}
	dodir /var/lib/transifex/scratchdir/sources/{bzr,cvs,git,hg,svn,tar}
	if use doc ; then
		dohtml -r docs/html/* || die "dohtml failed"
	fi
#	doenvd "${T}/50${PN}" || die

	insinto /etc/${PN}
	doins ${PN}/settings/*.conf
	insinto "${MY_HTDOCSDIR#${EPREFIX}}"
	doins -r transifex/media/*
#	for i in charts locks timeline widgets ; do
#		insinto "${MY_HTDOCSDIR#${EPREFIX}}"
#		doins -r transifex/addons/${i}/media/*
#	done
}

pkg_postinst() {
	elog "Edit /etc/${PN}/20-engines.conf"
	elog "then run emerge --config =${CATEGORY}/${PF}"
	echo
	elog "For futher installation and updating instructions please refer"
	elog "http://docs.transifex.org/intro/install.html"
	echo
}

pkg_config() {
	cd ${TX_HOME}
	echo
	einfo "Initialization database"
	echo
	python manage.py txcreatedirs || die
	python manage.py syncdb --noinput || die
	python manage.py migrate || die
	python manage.py txlanguages || die
	python manage.py txcreatenoticetypes || die
	python manage.py build_static --noinput || die
	echo
	einfo "Creating superuser"
	einfo "If you already have one, just press Ctrl+C"
	echo
	python manage.py createsuperuser || die
}