# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit cmake-utils games

DESCRIPTION="Help a girl by name of Violet to struggle with hordes of monsters."
HOMEPAGE="http://code.google.com/p/violetland/"
SRC_URI="http://violetland.googlecode.com/files/${PN}-v${PV}-src.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND="media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-mixer
	media-libs/sdl-ttf
	virtual/opengl"

DOCS="README_EN.TXT"
S="${WORKDIR}"/${PN}-v${PV}

src_prepare() {
	epatch "${FILESDIR}"/${P}-DATA_INSTALL_DIR.patch
}

src_configure() {
	# It's OK, patch done all things to LHS pleased
	local mycmakeargs="-DCMAKE_INSTALL_PREFIX=${GAMES_PREFIX} -DDATA_INSTALL_DIR=${GAMES_DATADIR}"
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	newicon icon-light.png ${PN}.png
	make_desktop_entry ${PN} VioletLand ${PN}.png
	prepgamesdirs
}

