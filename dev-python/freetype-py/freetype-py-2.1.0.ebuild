# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )
inherit distutils-r1

MY_PV=${PV/_p/.post}

DESCRIPTION="Python binding for the freetype library"
HOMEPAGE="https://github.com/rougier/freetype-py"
SRC_URI="mirror://pypi/${PN::1}/${PN}/${PN}-${MY_PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/freetype:2"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${MY_PV}"
