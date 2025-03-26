# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )
inherit distutils-r1

DESCRIPTION="Python client for Consul"
HOMEPAGE="
	https://python-consul.readthedocs.io/
	https://github.com/cablehead/python-consul
"
SRC_URI="https://github.com/cablehead/python-consul/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/aiohttp[${PYTHON_USEDEP}]
	>=dev-python/requests-2.0[${PYTHON_USEDEP}]
	>=dev-python/six-1.4[${PYTHON_USEDEP}]
	"
BDEPEND="
	test? (
		dev-python/tornado[${PYTHON_USEDEP}]
		dev-python/treq[${PYTHON_USEDEP}]
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		dev-python/pytest-twisted[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
RESTRICT="test" # test framework unrunnable, outdated API
