# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/openttd/openttd-0.7.4.ebuild,v 1.1 2009/12/09 17:03:30 mr_bones_ Exp $

EAPI=2
inherit eutils games

OPENGFX_VER=0.2.1
OPENSFX_VER=0.2.1

MY_PV=${PV/_/-}

DESCRIPTION="OpenTTD is a clone of Transport Tycoon Deluxe"
HOMEPAGE="http://www.openttd.org/"
SRC_URI="http://binaries.openttd.org/releases/${MY_PV}/${PN}-${MY_PV}-source.tar.bz2
	http://bundles.openttdcoop.org/opengfx/releases/opengfx-${OPENGFX_VER}.zip
	http://bundles.openttdcoop.org/opensfx/releases/opensfx-${OPENSFX_VER}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="alsa debug dedicated iconv icu +png +truetype zlib"
RESTRICT="test"

DEPEND="
	!dedicated? (
		media-libs/libsdl[audio,X,video]
		icu? ( dev-libs/icu )
		truetype? (
			media-libs/fontconfig
			media-libs/freetype:2
			sys-libs/zlib
		)
	)
	iconv? ( virtual/libiconv )
	png? ( media-libs/libpng )
	zlib? ( sys-libs/zlib )
	app-arch/unzip"
RDEPEND="${DEPEND}
	!dedicated? (
		alsa? ( media-sound/alsa-utils )
	)"

S=${WORKDIR}/${PN}-${MY_PV}

src_configure() {
	local myopts

	use debug && myopts="${myopts} --enable-debug=3"

	if use dedicated ; then
		myopts="${myopts} --enable-dedicated"
	else
		use alsa && myopts="${myopts} --with-midi=/usr/bin/aplaymidi"
		myopts="${myopts}
			$(use_with truetype freetype)
			$(use_with icu)
			--with-sdl"
	fi
	if use png || { use !dedicated && use truetype; } || use zlib ; then
		myopts="${myopts} --with-zlib"
	else
		myopts="${myopts} --without-zlib"
	fi

	# there is an allegro interface available as well as sdl, but
	# the configure for it looks broken so the sdl interface is
	# always built instead.
	myopts="${myopts} --without-allegro"

	# configure is a hand-written bash-script, so econf will not work
	./configure \
		--disable-strip \
		--prefix-dir=/ \
		--binary-dir="${GAMES_BINDIR}" \
		--data-dir="${GAMES_DATADIR}/${PN}" \
		--install-dir="${D}" \
		--icon-dir=/usr/share/pixmaps \
		--menu-dir=/usr/share/applications \
		--icon-theme-dir=/usr/share/icons/hicolor \
		--man-dir=/usr/share/man/man6 \
		--doc-dir=/usr/share/doc/${PF} \
		--menu-group="Game;Simulation;" \
		${myopts} \
		$(use_with iconv) \
		$(use_with png) \
		|| die "configure failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	if use dedicated ; then
		newinitd "${FILESDIR}"/${PN}.initd ${PN}
		rm -rf "${D}"/usr/share/{applications,icons,pixmaps}
	fi
	rm -f "${D}"/usr/share/doc/${PF}/COPYING

	insinto "${GAMES_DATADIR}"/${PN}/data/
	doins "${WORKDIR}"/opengfx-${OPENGFX_VER}/*.grf
	doins "${WORKDIR}"/opengfx-${OPENGFX_VER}/opengfx.obg
#	touch "${D}/${GAMES_DATADIR}"/${PN}/data/sample.cat

	doins "${WORKDIR}"/opensfx-${OPENSFX_VER}/opensfx.cat
	doins "${WORKDIR}"/opensfx-${OPENSFX_VER}/opensfx.obs

	prepalldocs
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst

	elog
	elog "In order to play, you must copy the following file from "
	elog "a version of TTD to ${GAMES_DATADIR}/${PN}/data/."
	elog
	elog "From the WINDOWS version you need sample.cat"
	elog "OR from the DOS version you need SAMPLE.CAT"
	elog
	elog "File names are case sensitive so make sure they are "
	elog "correct for whichever version you have."
	elog

	if use dedicated ; then
		ewarn "Warning: The init script will kill all running openttd"
		ewarn "processes when run, including any running client sessions!"
	else
		if use alsa ; then
			elog "You have emerged with 'aplaymidi' for playing MIDI."
			elog "You have to set the environment variable ALSA_OUTPUT_PORTS."
			elog "Available ports can be listed by using 'aplaymidi -l'."
		else
			elog "alsa not in USE so music will not be played during the game."
		fi
	fi
}
