# Copyright 2018-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg-utils

DESCRIPTION="Retro Computer Image Library"
HOMEPAGE="http://recoil.sourceforge.net/"
SRC_URI="https://downloads.sourceforge.net/project/${PN}/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gimp"

DEPEND="media-libs/libpng:0="
RDEPEND="${DEPEND}"
BDEPEND="
	dev-libs/libxslt
	gimp? ( media-gfx/gimp )
"

PATCHES=(
	"${FILESDIR}/${PN}-6.4.0_Makefile-fixes.patch"
)

src_compile() {
	default
	use gimp && emake file-recoil
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" BUILDING_PACKAGE=ON install
	use gimp && emake DESTDIR="${D}" PREFIX="/usr" BUILDING_PACKAGE=ON libdir=/usr/$(get_libdir) install-gimp
	dodoc README
}

pkg_postinst() {
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_mimeinfo_database_update
}
