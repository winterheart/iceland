# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

MY_PN="${PN/firmware/fw}"
MY_PV="${PV/.0}"

DESCRIPTION="Intel (R) WiMAX 5150/53500 Firmware"
HOMEPAGE="http://www.linuxwimax.org"
SRC_URI="http://www.linuxwimax.org/Download?action=AttachFile&do=get&target=${MY_PN}-${PV}.tar.bz2
-> ${MY_PN}-${PV}.tar.bz2"

LICENSE="IFDBL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}"/${MY_PN}-${PV}

src_install() {
	insinto /lib/firmware
	doins "${S}/${MY_PN}-usb-${MY_PV}.sbcf"

	dodoc README
}
