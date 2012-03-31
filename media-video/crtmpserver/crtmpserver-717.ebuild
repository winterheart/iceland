# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit cmake-utils eutils

DESCRIPTION="C++ RTMP Server is a high performance streaming server"
HOMEPAGE="http://www.rtmpd.com/"
SRC_URI="http://rtmpd.org/assets/sources/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/lua
	dev-libs/openssl
	dev-libs/tinyxml"
RDEPEND="${DEPEND}"

CMAKE_USE_DIR="${S}/builders/cmake"

src_prepare() {
	# Fix broken PCH support
	# http://public.kitware.com/Bug/view.php?id=1260
	cp "${FILESDIR}/pch_support.cmake" "${CMAKE_USE_DIR}/cmake_find_modules/"

	epatch "${FILESDIR}/${P}-disable-Werror.patch"
}
