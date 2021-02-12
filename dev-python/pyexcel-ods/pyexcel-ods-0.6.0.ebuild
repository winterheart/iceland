# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )
inherit distutils-r1

DESCRIPTION="Plugin to pyexcel for ODS support"
HOMEPAGE="https://github.com/pyexcel/pyexcel-ods/"
SRC_URI="https://github.com/pyexcel/pyexcel-ods/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-python/odfpy-1.3.3
	>=dev-python/pyexcel-io-0.5.3"
RDEPEND="${DEPEND}"
