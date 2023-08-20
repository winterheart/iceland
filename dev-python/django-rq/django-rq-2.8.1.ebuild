# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_11 )

inherit distutils-r1

DESCRIPTION="A simple app that provides django integration for RQ (Redis Queue)"
HOMEPAGE="https://github.com/rq/django-rq/ https://pypi.org/project/django-rq/"
SRC_URI="https://github.com/rq/django-rq/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
# Requires redis live connection
RESTRICT="test"

RDEPEND="
	>=dev-python/django-2.0[${PYTHON_USEDEP}]
	>=dev-python/rq-1.4.0[${PYTHON_USEDEP}]
	>=dev-python/redis-3.0.0[${PYTHON_USEDEP}]
"

#python_test() {
#	"${EPYTHON}" -m django test django_rq --settings=django_rq.tests.settings --pythonpath=. || die
#}
