# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit distutils

DESCRIPTION="Generic User Profile Control Panel developed for django"
HOMEPAGE="http://code.google.com/p/django-profile/"
SRC_URI="http://ftp.gentoo.ru/people/winterheart/distfiles/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=">dev-python/django-1.2
	dev-python/imaging"

S="${WORKDIR}/${PN}"
