# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )
inherit distutils-r1

DESCRIPTION="API to read and write the data in spreadsheet format"
HOMEPAGE="http://pyexcel-io.readthedocs.io https://github.com/pyexcel/pyexcel-io"
SRC_URI="https://github.com/pyexcel/pyexcel-io/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
#"test? ( dev-python/nose[${PYTHON_USEDEP}] )"

#python_test() {
#	nosetests -v || die "Tests failed under ${EPYTHON}."
#}
