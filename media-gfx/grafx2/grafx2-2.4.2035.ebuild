# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="GrafX2 is a bitmap paint program inspired by the Amiga programs"
HOMEPAGE="http://pulkomandy.tk/projects/GrafX2/wiki"
SRC_URI="http://pulkomandy.tk/projects/GrafX2/downloads/21 -> ${P}-src.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="lua truetype"

DEPEND="lua? ( dev-lang/lua:0 )
	truetype? ( media-libs/freetype:2
		media-libs/sdl-ttf:0 )
	media-libs/libpng:0
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
