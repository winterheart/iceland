# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit multilib

DESCRIPTION="Intel WiMAX Binary Supplicant"
HOMEPAGE="http://www.linuxwimax.org"
SRC_URI="http://linuxwimax.org/Download?action=AttachFile&do=get&target=Intel-WiMAX-Binary-Supplicant-1.4.0.tar.bz2 -> Intel-WiMAX-Binary-Supplicant-${PV}.tar.bz2"

LICENSE="Intel-binary"
SLOT="0"
# There not yet 64bit supplicant exist
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-libs/openssl"

S="${WORKDIR}"/Intel-WiMAX-Binary-Supplicant-${PV}

src_install() {
	insinto /usr/$(get_libdir)/wimax
	# ume or midinux???
	for target in ume midinux ; do
		if ldd "${WORKDIR}"/$target/libwpa_wimax_supplicant.so* | grep -q "not found" ; then
			continue
		else
			doins ume/libwpa_wimax_supplicant.so.0
			exit
		fi
	done
#	dosym /usr/$(get_libdir)/wimax/libwpa_wimax_supplicant.so.0 /usr/$(get_libdir)/wimax/libwpa_wimax_supplicant.so
	dodoc README
}

