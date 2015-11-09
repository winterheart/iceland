# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="GrafX2 is a bitmap paint program inspired by the Amiga programs Deluxe Paint and Brilliance."
HOMEPAGE="http://code.google.com/p/grafx2/"
SRC_URI="http://grafx2.googlecode.com/files/${P}-src.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="lua truetype"

DEPEND="lua? ( dev-lang/lua )
	truetype? ( media-libs/freetype:2
		media-libs/sdl-ttf:0 )
	media-libs/libpng
	media-libs/libsdl
	media-libs/sdl-image"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}/src"

src_compile() {
	local myarg
	use lua || myarg="$myarg NOLUA=1"
	use truetype || myarg="$myarg NOTTF=1"
	emake $myarg
}

src_install() {
	emake prefix="${D}/usr" install
}
