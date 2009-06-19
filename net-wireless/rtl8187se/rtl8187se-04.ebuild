# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/rtl8187/rtl8187-1.10.ebuild,v 1.4 2007/05/09 20:00:14 genstef Exp $

inherit eutils linux-mod

DESCRIPTION="Driver for the wireless card Realtek 8187se"
HOMEPAGE="http://code.google.com/p/msi-wind-linux/"
SRC_URI="http://msi-wind-linux.googlecode.com/files/${PN}_linux-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S=${WORKDIR}/rtl8187se_coffee

MODULE_NAMES="ieee80211_crypt-rtl(net:${S}/ieee80211) ieee80211_crypt_wep-rtl(net:${S}/ieee80211)
	ieee80211_crypt_tkip-rtl(net:${S}/ieee80211) ieee80211_crypt_ccmp-rtl(net:${S}/ieee80211)
	ieee80211-rtl(net:${S}/ieee80211) r8180(net:${S}/rtl8185)"
BUILD_TARGETS=" "
MODULESD_R8187SE_ALIASES=("wlan0 r8180")

pkg_setup() {
	if ! kernel_is 2 6 ; then
		eerror "This driver is for kernel version 2.6 or greater only!"
		die "No kernel version 2.6 or greater detected!"
	fi
	linux-mod_pkg_setup
	local CONFIG_CHECK="WIRELESS_EXT CRYPTO CRYPTO_ARC4 CRC32 !IEEE80211"
	local ERROR_IEEE80211="${P} requires the in-kernel version of the IEEE802.11 subsystem to be disabled (CONFIG_IEEE80211)"
	check_extra_config
	BUILD_PARAMS="KSRC=${KV_DIR}"
}

src_install() {
	linux-mod_src_install
	dodoc wlan0* rtl8185/{authors,changes,readme}
}

pkg_postinst() {
	linux-mod_pkg_postinst

	elog "You may want to add the following modules to"
	elog "/etc/modules.autoload.d/kernel-2.6"
	elog
	elog "The module itself:       r8180"
	elog "WEP and WPA encryption:  ieee80211_crypt-rtl"
	elog "WEP encryption:          ieee80211_crypt_wep-rtl"
	elog "WPA TKIP encryption:     ieee80211_crypt_tkip-rtl"
	elog "WPA CCMP encryption:     ieee80211_crypt_ccmp-rtl"
	elog "For the r8180 module:    ieee80211-rtl"
}
