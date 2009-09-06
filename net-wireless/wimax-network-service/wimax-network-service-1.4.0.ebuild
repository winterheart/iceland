# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils

DESCRIPTION="Intel WiMAX Network Service"
HOMEPAGE="http://www.linuxwimax.org/"
SRC_URI="http://www.linuxwimax.org/Download?action=AttachFile&do=get&target=WiMAX-Network-Service-${PV}.tar.bz2 -> WiMAX-Network-Service-${PV}.tar.bz2"

LICENSE="BSD"
SLOT="0"

# Because supplicant x86 only
KEYWORDS="~x86"
IUSE="debug tools"

DEPEND=">=dev-libs/libnl-1.1
	net-wireless/intel-wimax-binary-supplicant"
RDEPEND=""

src_configure() {
	# ugly baaaad hack!!! You batrad, you know it?!
	econf --with-i2400m=/usr/src/linux \
		$(use_with debug) \
		$(use_with tools) \
		|| die "ecoonf failed"
}

