# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit cmake-utils linux-info

DESCRIPTION="A high performance pptp plugin for pppd"
HOMEPAGE="http://accel-ppp.org/"
SRC_URI="https://github.com/winterheart/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=net-dialup/ppp-2.4.2"
RDEPEND="${DEPEND}"

CONFIG_CHECK="~PPTP"

DOCS="README"

src_configure() {
	mycmakeargs=(
		"-DPPP_PREFIX_DIR=/usr"
	)
	cmake-utils_src_configure
}
