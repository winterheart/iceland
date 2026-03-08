# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )
inherit distutils-r1

DESCRIPTION="A Python parser for MediaWiki wikicode"
HOMEPAGE="https://github.com/earwig/mwparserfromhell"
SRC_URI="https://github.com/earwig/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

PATCHES=(
	"${FILESDIR}/mwparserfromhell-0.6.4_gallery.patch"
)

src_prepare() {
	distutils-r1_src_prepare
	export SETUPTOOLS_SCM_PRETEND_VERSION=${PV}
}
