# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="Firmware for RTL8182SE-based wireless network cards"
HOMEPAGE="http://www.realtek.com.tw"
SRC_URI="ftp://www.gentoo.ru/pub/${PN}/${P}.tar.bz2"

LICENSE="Realtek-Firmware-License"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	insinto /lib/firmware/RTL8192SE
	doins *.bin
}
