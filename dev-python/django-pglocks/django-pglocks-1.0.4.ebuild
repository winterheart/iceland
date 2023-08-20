# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )
PYPI_NO_NORMALIZE=true

inherit distutils-r1 pypi

DESCRIPTION="PostgreSQL locking context managers and functions for Django"
HOMEPAGE="https://pypi.org/project/django-pglocks/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
# Needs running postrges database to test
RESTRICT="test"

RDEPEND="
	>=dev-python/django-3.2[${PYTHON_USEDEP}]
	>=dev-python/six-1.0.0[${PYTHON_USEDEP}]
"

PATCHES=(
	"${FILESDIR}/${PN}-1.0.4-setuptools.patch"
)
