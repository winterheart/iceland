# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit autotools eutils games

DESCRIPTION="D2X Revolution is a port of Descent 2 to OpenGL"
HOMEPAGE="http://www.descent2.de/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="D2X-XL"
SLOT="0"
KEYWORDS="~amd64"
IUSE="cdinstall directfb ggi opengl svga"

DEPEND="media-libs/libsdl
		>=media-libs/sdl-mixer-1.2.8
		media-libs/sdl-image
		media-libs/libogg
		media-libs/libvorbis
		media-libs/smpeg
		ggi? ( media-libs/libggi )
		opengl? ( virtual/opengl )
		directfb? ( dev-libs/DirectFB )"
RDEPEND="${DEPEND}
		cdinstall? ( games-action/descent2-data )
		!cdinstall? ( games-action/descent2-demodata )"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	eautoreconf
}

src_compile() {
	econf --enable-release --with-sharepath=/usr/share/games/d2x \
		$(use_with ggi) \
		$(use_with opengl) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	dogamesbin d2x-xl
	local options="-fullscreen -grabmouse -sound22k	-render_quality 3 \
		-gl_alttexmerge 1 -playermessages -noredundancy -nomovies 1 -pps 10 \
		-render2texture 1 -menustyle 1 -fastmenus 1 -sdl_mixer 1 \
		-use_d1sounds 1 -altbg_brightness 0.75 -altbg_alpha -1.0 \
		-altbg_grayscale 0 -hires_textures 1 -hires_sound 2 -hires_models 1 \
		-cache_lights 1 -cache_lightmaps 1 -cache_meshes 1 -cache_textures 1 \
		-cache_ 1 -fixmodels 1 -altmodels 1 -hogdir /usr/share/games/d2x"
	games_make_wrapper ${PN}-common "${PN} ${options}"
}

