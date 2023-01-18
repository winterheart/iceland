# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} )
inherit distutils-r1

DESCRIPTION="API to read and write the data in spreadsheet format"
HOMEPAGE="http://pyexcel-io.readthedocs.io https://github.com/pyexcel/pyexcel-io"
SRC_URI="https://github.com/pyexcel/pyexcel-io/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RESTRICT="test"
DEPEND=""
#"test? ( dev-python/nose[${PYTHON_USEDEP}] )"

#python_test() {
#	nosetests -v || die "Tests failed under ${EPYTHON}."
#}
