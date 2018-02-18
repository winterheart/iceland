# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )
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
