# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )
inherit distutils-r1

DESCRIPTION="A library for replicating between multiple servers, based on raft protocol"
HOMEPAGE="
	https://github.com/bakwc/PySyncObj
	https://pypi.org/project/pysyncobj/
"
SRC_URI="https://github.com/bakwc/PySyncObj/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
S="${WORKDIR}/PySyncObj-${PV}"

distutils_enable_tests pytest
