# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )
inherit distutils-r1

DESCRIPTION="A high-level Python library to use Apache Zookeeper"
HOMEPAGE="
	https://github.com/python-zk/kazoo
	https://pypi.org/project/kazoo/
"
SRC_URI="https://github.com/python-zk/kazoo/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/six[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
RESTRICT="test"
