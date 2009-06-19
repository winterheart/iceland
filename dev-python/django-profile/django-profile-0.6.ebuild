# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit distutils

DESCRIPTION="Generic User Profile Control Panel developed for django"
HOMEPAGE="http://code.google.com/p/django-profile/"
SRC_URI="http://django-profile.googlecode.com/files/${P}.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-python/imaging"

S="${WORKDIR}/${PN}"

src_prepare() {
	cp "${FILESDIR}/setup.py" "${S}"
}
