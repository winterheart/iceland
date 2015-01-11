# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python3{_2,_3,_4} )
inherit distutils-r1 git-2

DESCRIPTION="A Python parser for MediaWiki wikicode"
HOMEPAGE="https://github.com/earwig/mwparserfromhell"
EGIT_REPO_URI="https://github.com/earwig/mwparserfromhell.git"
#SRC_URI="https://githiub.com/earwig/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
