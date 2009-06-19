# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit games

DESCRIPTION="Descent Rebirth - enhanced Descent 2 engine"
HOMEPAGE="http://www.dxx-rebirth.de/"
SRC_URI="mirror://sourceforge/dxx-rebirth/${PN}_v${PV}-src.tar.gz
		http://www.dxx-rebirth.com/download/dxx/res/dxx-rebirth_icons.zip
		linguas_de? ( http://www.dxx-rebirth.com/download/dxx/res/D1XBDE01.zip )"
# bug #117344
LICENSE="D1X GPL-2 as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug cdinstall ipv6 linguas_de opengl"

DEPEND="app-arch/unzip
		dev-games/physfs
		dev-util/scons
		media-libs/libsdl
		media-libs/sdl-mixer"
RDEPEND="virtual/opengl
		virtual/glu
		cdinstall? ( games-action/descent1-data )
		!cdinstall? ( games-action/descent1-demodata )"

S=${WORKDIR}/${PN}_v${PV}-src

scons_use_enable() {
	use ${2} && echo "${1}=1" || echo "${1}=0"
}

src_compile() {
	scons ${MAKEOPTS} \
		sharepath="${GAMES_DATADIR}/d1x" \
		sdlmixer=1 \
		$(scons_use_enable debug debug) \
		$(scons_use_enable sdl_only !opengl) \
		$(scons_use_enable ipv6 ipv6)
}

src_install() {
	insinto "${GAMES_DATADIR}/d1x"
	if use linguas_de ; then
		doins "${WORKDIR}"/D1XBDE01/D1XbDE01/*.txb
	fi
	doicon "${WORKDIR}/${PN}.xpm"
	if use opengl ; then
		dogamesbin d1x-rebirth-gl
	    make_desktop_entry d1x-rebirth-gl "Descent Rebirth" ${PN}.xpm
	else
		dogamesbin d1x-rebirth-sdl
		make_desktop_entry d1x-rebirth-sdl "Descent Rebirth" ${PN}.xpm
	fi
	prepgamesdirs
}

