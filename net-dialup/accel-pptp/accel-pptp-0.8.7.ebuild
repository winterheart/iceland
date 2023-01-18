# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake linux-info

DESCRIPTION="A high performance pptp plugin for pppd"
HOMEPAGE="http://accel-ppp.org/"
SRC_URI="https://github.com/winterheart/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=">=net-dialup/ppp-2.4.2"
RDEPEND="${DEPEND}"

CONFIG_CHECK="~PPTP"

DOCS="README"

src_configure() {
	mycmakeargs=(
		"-DPPP_PREFIX_DIR=/usr"
	)
	cmake_src_configure
}
