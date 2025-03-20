# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
#DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="Python client for Consul"
HOMEPAGE="
	https://www.consul.io/
	https://pypi.org/project/py-consul/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/requests-2.0"
#BDEPEND="
#	test? ()
#"

#distutils_enable_tests pytest

# Complex test framework
RESTRICT="test"

src_prepare() {
	default

	sed -i -e "/data_files=/d" setup.py || die
	rm -fr docs
}
