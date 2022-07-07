# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..10} )
inherit distutils-r1

DESCRIPTION="Library for working with BDF font files"
HOMEPAGE="https://gitlab.com/Screwtapello/bdflib/wikis/home "
SRC_URI="https://gitlab.com/Screwtapello/bdflib/-/archive/v${PV}/${PN}-v${PV}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
#"test? ( dev-python/nose[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${PN}-v${PV}"

#python_test() {
#	nosetests -v || die "Tests failed under ${EPYTHON}."
#}
