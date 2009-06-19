# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils linux-mod

DESCRIPTION="Driver for the wireless card Realtek 8187se"
HOMEPAGE="http://www.gentoo.ru"
SRC_URI="ftp://ftp.gentoo.ru/pub/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

MODULE_NAMES="rtl8187se(net/wireless:${S}:${S})"
CONFIG_CHECK="PCI WIRELESS_EXT"
BUILD_TARGETS="modules"
MODULESD_RTL8187SE_ALIASES=("wlan0 rtl8187se")

src_install() {
	linux-mod_src_install
	dodoc README
}

