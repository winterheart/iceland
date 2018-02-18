# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="A set of fast command-line tools for manipulationg Gimp's file format XCF."
HOMEPAGE="http://henning.makholm.net/software"
SRC_URI="http://henning.makholm.net/${PN}/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
# nls support is broken, we cannot USE nls flag.
IUSE=""

DEPEND=">=media-libs/libpng-1.6:0=
	sys-devel/gettext
	virtual/pkgconfig"
RDEPEND=">=media-libs/libpng-1.6:0=
	virtual/libintl"

PATCHES=(
	"${FILESDIR}/0001-Fix-compilation-against-libpng-1.5.patch"
	"${FILESDIR}/0002-Fix-build-system-to-use-correct-libraries.patch"
	"${FILESDIR}/0003-Remove-strip-from-install-target.patch"
)

src_configure() {
	econf --enable-nls
}
