# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit cmake-utils linux-info

DESCRIPTION="A high performance pptp plugin for pppd"
HOMEPAGE="http://accel-ppp.org/"
SRC_URI="https://github.com/downloads/winterheart/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=net-dialup/ppp-2.4.2"
RDEPEND="${DEPEND}"

CONFIG_CHECK="~PPTP"

DOCS="README"
