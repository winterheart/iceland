# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# Ebuild generated by g-pypi 0.2.1 (rev. 204)

inherit distutils subversion

MY_P=tagging

DESCRIPTION="Generic tagging application for Django"
HOMEPAGE="http://code.google.com/p/django-tagging/"
ESVN_REPO_URI="http://django-tagging.googlecode.com/svn/trunk/"
#SRC_URI="http://django-tagging.googlecode.com/files/${MY_P}-${PV}.zip"

LICENSE="BSD-2"
KEYWORDS=""
SLOT="0"
IUSE=""
DEPEND="app-arch/unzip"
RDEPEND=""

S="${WORKDIR}"/${MY_P}-${PV}
