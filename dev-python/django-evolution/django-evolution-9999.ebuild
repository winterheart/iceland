# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
inherit distutils subversion

DESCRIPTION="Schema Evolution for the Django Project"
HOMEPAGE="http://code.google.com/p/django-evolution/"
ESVN_REPO_URI="http://django-evolution.googlecode.com/svn/trunk/"

#SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=">=dev-python/django-1.0"
