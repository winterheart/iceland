# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit games

DESCRIPTION="Descent Rebirth - enhanced Descent 2 engine"
HOMEPAGE="http://www.dxx-rebirth.de/"
SRC_URI="mirror://sourceforge/dxx-rebirth/${PN}_v${PV}-src.tar.gz
		http://www.dxx-rebirth.com/download/dxx/res/dxx-rebirth_icons.zip
		linguas_de? ( http://www.dxx-rebirth.com/download/dxx/res/D2XBDE01.zip )"
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
		cdinstall? ( games-action/descent2-data )"
# Not work with demo-data
#		!cdinstall? ( games-action/descent2-demodata )"

S=${WORKDIR}/${PN}_v${PV}-src

scons_use_enable() {
	use ${2} && echo "${1}=1" || echo "${1}=0"
}

src_compile() {
	scons ${MAKEOPTS} \
		sharepath="${GAMES_DATADIR}/d2x" \
		sdlmixer=1 \
		$(scons_use_enable debug debug) \
		$(scons_use_enable sdl_only !opengl) \
		$(scons_use_enable ipv6 ipv6)
}

src_install() {
	dodoc INSTALL.txt README.txt
	insinto "${GAMES_DATADIR}/d2x"
	if use linguas_de ; then
		doins "${WORKDIR}"/D2XBDE01/D2XbDE01/*.txb
	fi
	doicon "${WORKDIR}/${PN}.xpm"

	if use opengl ; then
		newgamesbin d2x-rebirth-gl d2x-rebirth
	else
		newgamesbin d2x-rebirth-sdl d2x-rebirth
	fi
	make_desktop_entry d2x-rebirth "Descent 2 Rebirth" ${PN}.xpm
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	if ! use cdinstall ; then
		echo
		elog "You need to copy data-files from original Descent 2"
		elog "installation to ${GAMES_DATADIR}/d2x. Please read "
		elog "/usr/share/doc/${PF}/INSTALL.txt for more info."
		echo
	fi
}

