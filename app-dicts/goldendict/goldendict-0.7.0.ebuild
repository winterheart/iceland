# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit qt4 eutils

DESCRIPTION="Feature-rich dictionary lookup program"
HOMEPAGE="http://goldendict.berlios.de/"
SRC_URI="mirror://berlios/${PN}/${P}-src.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="${RDEPEND}
	>=x11-libs/qt-core-4.5
	>=x11-libs/qt-gui-4.5
	>=x11-libs/qt-webkit-4.5"
RDEPEND="dev-libs/libzip
	media-libs/libvorbis"

src_compile() {
	eqmake4 || die "eqmake failed"
	emake || die "emake failed"
}

src_install() {
	dobin goldendict
	newicon icons/programicon.png ${PN}.png
	make_desktop_entry ${PN} GoldenDict ${PN}.png "Qt;Utility;Dictionary;"
}

