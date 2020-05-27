# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )
inherit distutils-r1

DESCRIPTION="Lock context manager implemented via redis SETNX/BLPOP"
HOMEPAGE="https://pypi.org/project/python-redis-lock/ https://github.com/ionelmc/python-redis-lock"
SRC_URI="https://github.com/ionelmc/python-redis-lock/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	>=dev-python/django-redis-3.8.0[${PYTHON_USEDEP}]
	dev-python/redis-py[${PYTHON_USEDEP}]"

#distutils_enable_tests pytest
