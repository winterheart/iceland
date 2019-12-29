# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_5 python3_6 python3_7 )
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
