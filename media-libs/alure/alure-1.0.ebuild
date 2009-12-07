# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit cmake-utils multilib

DESCRIPTION="A utility library to help manage common tasks with OpenAL applications"
HOMEPAGE="http://kcat.strangesoft.net/alure.html"
SRC_URI="http://kcat.strangesoft.net/alure-releases/${P}-src.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc sndfile static vorbis"

# Flac is broken
# flac? ( media-libs/flac )
DEPEND="media-libs/openal
	sndfile? ( media-libs/libsndfile )
	vorbis? ( media-libs/libvorbis )"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}_multilib_pkgconfig.patch
	epatch "${FILESDIR}"/${P}_compile_with_gcc44.patch
}

src_configure() {
	# $(cmake-utils_use flac FLAC)
	mycmakeargs="${mycmakeargs}
		-DLIB_INSTALL_DIR=$(get_libdir)
		-DFLAC=OFF
		$(cmake-utils_use static NO_SHARED)
		$(cmake-utils_use sndfile SNDFILE)
		$(cmake-utils_use vorbis VORBIS)"
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	if use !doc ; then
		rm -fr "${D}"/usr/share/doc || die "Failed"
	fi
}

