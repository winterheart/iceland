# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit distutils

DESCRIPTION="A command line interface for Transifex"
HOMEPAGE="http://www.indifex.com/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	dev-python/poster"

pkg_postinst() {
	distutils_pkg_postinst

	elog "See http://trac.transifex.org/wiki/Development/Transifex-1.0 for using."
}
