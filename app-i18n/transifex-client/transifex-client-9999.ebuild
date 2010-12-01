# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit distutils mercurial

DESCRIPTION="A command line interface for Transifex"
HOMEPAGE="http://www.indifex.com/"
#SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
EHG_REPO_URI="http://bitbucket.org/indifex/transifex-client"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	dev-python/poster"

pkg_postinst() {
	distutils_pkg_postinst

	elog "See http://help.transifex.net/user-guide/client/client-0.2.html for using."
}
