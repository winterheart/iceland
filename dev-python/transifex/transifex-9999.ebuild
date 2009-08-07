# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# Ebuild generated by g-pypi 0.2.1 (rev. 204)

EAPI="2"

inherit distutils mercurial multilib

DESCRIPTION="A platform for distributed translation submissions"
HOMEPAGE="http://transifex.org/"
#SRC_URI="http://transifex.org/files/${P}.tar.gz"
EHG_REPO_URI="http://code.transifex.org/mainline"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"

IUSE="mysql sqlite postgres subversion"
DEPEND="dev-python/setuptools
	mysql? ( dev-python/django[mysql] )
	sqlite? ( dev-python/django[sqlite] )
	postgres? ( dev-python/django[postgres] )"

# spinx is really useless unless USE="doc", I will fix it later
RDEPEND=">=dev-python/django-1.0
	dev-python/django-authority
	dev-python/django-authopenid
	=dev-python/django-contact-form-9999
	>=dev-python/django-notification-0.1.2
	>=dev-python/django-pagination-1.0.5
	dev-python/django-tagging
	dev-python/django-profile
	>=dev-python/pygments-0.9
	dev-python/markdown
	dev-python/polib
	dev-python/sphinx
	dev-python/south
	dev-python/urlgrabber
	sys-devel/gettext
	subversion? ( dev-python/pysvn )"

S="${WORKDIR}"/mainline

# In future it may help
src_prepare() {
	# Own directory
	epatch "${FILESDIR}"/setup.py.patch || die "epatch failed"
	# Adding .py to installation
	echo "recursive-include transifex *.py" >> "${S}"/MANIFEST.in
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
}

pkg_postinst() {
	einfo
}

