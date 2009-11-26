# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit games subversion

DESCRIPTION="A cross-platform 3D game interpreter for play LucasArts' LUA-based 3D adventures"
HOMEPAGE="http://residual.sourceforge.net/"
#SRC_URI=""
ESVN_REPO_URI="http://residual.svn.sourceforge.net/svnroot/residual/residual/trunk/"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE="flac mad vorbis"

DEPEND="flac? ( media-libs/flac )
	mad? ( media-libs/libmad )
	vorbis? ( media-libs/libvorbis )
	media-libs/libsdl
	sys-libs/zlib
	virtual/opengl"
RDEPEND="${DEPEND}"

src_configure() {
	# econf can't work here, configure script not have some options
	./configure --backend=sdl --enable-release --disable-tremor \
		--prefix="${GAMES_PREFIX}" \
		--datadir="${GAMES_DATADIR}" \
		$(use_enable flac) \
		$(use_enable mad) \
		$(use_enable vorbis) \
	|| die "configure failed"
}

src_install() {
	dogamesbin residual
	insinto "${GAMES_DATADIR}/residual"
	doins gui/themes/modern.zip
	doicon icons/residual.xpm
	make_desktop_entry ${PN} Residual residual.xpm
	dodoc README
	prepgamesdirs
}

