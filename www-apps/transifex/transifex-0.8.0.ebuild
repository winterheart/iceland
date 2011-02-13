# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit distutils multilib

DESCRIPTION="A platform for distributed translation submissions"
HOMEPAGE="http://www.transifex.org/"
SRC_URI="http://www.transifex.org/files/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"

IUSE="doc mysql sqlite postgres subversion"
DEPEND="dev-python/setuptools
	dev-python/django[mysql?,sqlite?,postgres?]
	>=dev-python/sphinx-0.4.2"

# spinx is really useless unless USE="doc", I will fix it later
# django-contact-form - hg 97559a887345 or newer
RDEPEND=">=dev-python/django-1.1
	dev-python/django-ajax-selects
	dev-python/django-authority
	>=dev-python/django-contact-form-0.3_p61
	>=dev-python/django-filter-0.1
	>=dev-python/django-notification-0.1.2
	>=dev-python/django-pagination-1.0.5
	dev-python/django-piston
	dev-python/django-profile
	>=dev-python/django-sorting-0.1
	>=dev-python/django-tagging-0.3
	dev-python/django-threadedcomments
	dev-python/httplib2
	>=dev-python/imaging-1.1.6
	dev-python/markdown
	>=dev-python/polib-0.5.1
	>=dev-python/pygments-0.9
	>=dev-python/south-0.6
	dev-python/urlgrabber
	sys-devel/gettext
	subversion? ( dev-python/pysvn )"

#S="${WORKDIR}"/mainline

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

	insinto /etc/transifex
	doins -r transifex/settings/*
	rm -fr "${D}"/usr/$(get_libdir)/python${PYVER}/site-packages/transifex/settings
	dosym /etc/transifex /usr/$(get_libdir)/python${PYVER}/site-packages/transifex/settings
	fperms 0755	/usr/$(get_libdir)/python${PYVER}/site-packages/transifex/manage.py

	rm -fr "${D}"/usr/templates
	# There should be fperm for properly saving
	keepdir /var/lib/transifex/scratchdir
	dodir /var/lib/transifex/scratchdir/{msgmerge_files,sources}
	dodir /var/lib/transifex/scratchdir/sources/{bzr,cvs,git,hg,svn,tar}
	if use doc ; then
		dohtml -r docs/html/* || die "dohtml failed"
	fi
}

pkg_postinst() {
	echo
	einfo "For installation and updating instructions please refer"
	einfo "http://docs.transifex.org/intro/install.html"
	echo
}
