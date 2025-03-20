# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )
inherit distutils-r1

EGIT_COMMIT="d2889f7b23feee8797657b19c404f0d4034dd03c"

DESCRIPTION="A python client for etcd"
HOMEPAGE="https://python-etcd.readthedocs.org/
	https://github.com/jplana/python-etcd"
SRC_URI="https://github.com/jplana/python-etcd/archive/${EGIT_COMMIT}.tar.gz -> ${P}.gh.tar.gz"

S="${WORKDIR}/${PN}-${EGIT_COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-python/dnspython[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"
BDEPEND="
	test? (
		dev-python/pyopenssl[${PYTHON_USEDEP}]
		dev-db/etcd
	)"

distutils_enable_tests pytest

PATCHES=(
	"${FILESDIR}/python-etcd-0.4.5_pytest.patch"
)

python_test() {
	local EPYTEST_DESELECT=(
		'src/etcd/tests/integration/test_simple.py::TestSimple::test_directory_ttl_update'
	)
	epytest
}
