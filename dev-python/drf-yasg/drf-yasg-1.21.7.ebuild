# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..12} )
PYPI_NO_NORMALIZE=true

inherit distutils-r1 pypi

DESCRIPTION="Yet another Swagger generator"
HOMEPAGE="https://pypi.org/project/drf-yasg/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"

RDEPEND="
	>=dev-python/django-2.2.16
	>=dev-python/djangorestframework-3.10.3
	>=dev-python/inflection-0.3.1
	>=dev-python/packaging-21.0
	>=dev-python/pytz-2021.1
	>=dev-python/pyyaml-5.1
	>=dev-python/uritemplate-3.0.0
"
