# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools

PYTHON_COMPAT=( python3_{10..11} )
inherit distutils-r1

MY_PV=${PV/_p/.post}
S="${WORKDIR}/${PN}-${MY_PV}"

DESCRIPTION="OpenStep plist parser and writer written in Cython"
HOMEPAGE="https://github.com/fonttools/openstep-plist"
SRC_URI="https://github.com/fonttools/openstep-plist/archive/refs/tags/v${MY_PV}.tar.gz -> ${PN}-${MY_PV}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="dev-python/cython"

distutils_enable_tests pytest
export SETUPTOOLS_SCM_PRETEND_VERSION=${MY_PV}
