# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="A program for announcing VLANs using GVRP"
HOMEPAGE="http://sokrates.mimuw.edu.pl/~sebek/gvrpcd/"
SRC_URI="http://sokrates.mimuw.edu.pl/~sebek/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-libs/libnet:1.1"
RDEPEND="${DEPEND}"

src_compile() {
	emake || die "emake failed"
}

src_install() {
	into /
	dosbin gvrpcd
	dodoc README
}
