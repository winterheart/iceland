# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A PC/SC driver for ACS CCID smart card readers"
HOMEPAGE="http://acsccid.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-apps/pcsc-lite
	virtual/libusb:0"
RDEPEND="${DEPEND}"

src_configure() {
	econf
}

src_install() {
	emake DESTDIR="${D}" install
	insinto "/lib/udev/rules.d"
	doins "src/92_pcscd_acsccid.rules"
}
