# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )
inherit distutils-r1

DESCRIPTION="A python client for etcd"
HOMEPAGE="https://python-etcd.readthedocs.org/
	https://github.com/jplana/python-etcd"
SRC_URI="https://github.com/jplana/python-etcd/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

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

#distutils_enable_tests nose

RESTRICT="test" # FAILURE, need to investigate, uses deprecated nose
