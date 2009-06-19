# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit games

DESCRIPTION="A game inspired by the classical Pong from Atari"
HOMEPAGE="http://pong2.berlios.de/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="media-libs/libsdl
		media-libs/sdl-net
		media-libs/sdl-image"

RDEPEND="virtual/opengl"

src_install() {
	emake DESTDIR="${D}" install || die "emakee failed"
	newicon "${S}/icon.png" ${PN}.png
	make_desktop_entry pong2 "Pong2" ${PN}.png
	prepgamesdirs
}
