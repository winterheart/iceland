# Copyright 2018-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Retro Computer Image Library"
HOMEPAGE="http://recoil.sourceforge.net/"
SRC_URI="https://downloads.sourceforge.net/project/${PN}/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="media-libs/libpng:0="
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${P}_LDFLAGS.patch"
)

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" recoil2png
}

src_install() {
	dobin recoil2png
	doman recoil2png.1
	dodoc README
}
