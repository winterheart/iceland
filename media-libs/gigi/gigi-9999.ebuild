# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils multilib subversion

EAPI=2

DESCRIPTION="GiGi is a small, efficient, and feature-rich C++ GUI for SDL and OpenGL."
HOMEPAGE="http://gigi.sourceforge.net/"
#SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
ESVN_REPO_URI="http://gigi.svn.sourceforge.net/svnroot/gigi/trunk/GG"
ESVN_PATCHES="${FILESDIR}/${PN}-symlinks.patch"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="jpeg devil ogre ois png sdl tiff"

CDEPEND="
		devil? ( media-libs/devil )
		media-libs/freetype:2
		dev-libs/boost:1.36
		ogre? ( >=dev-games/ogre-1.6.1
			ois? ( dev-games/ois ) )
		sdl? ( media-libs/libsdl )
		png? (
			devil? ( media-libs/devil[png] )
			!devil? ( media-libs/libpng ) )
		jpeg? (
			devil? ( media-libs/devil[jpeg] )
			!devil? ( media-libs/jpeg ) )
		tiff? (
			devil? ( media-libs/devil[tiff] )
			!devil? ( media-libs/tiff ) )"

DEPEND="${CDEPEND} dev-util/scons"

RDEPEND="${CDEPEND}"

pkg_setup() {
	if use !ogre && use ois
	then
		ewarn "ois-support without ogre won't be compiled."
	fi
}

src_compile() {
	local myconf=""
	if use !ogre
	then
		myconf="${myconf} build_ogre_driver=0"
	else
		if use !ois
		then
			myconf="${myconf} build_ogre_ois_plugin=0"
		fi
	fi
	use !sdl && myconf="${myconf} build_sdl_driver=0"
	use devil && myconf="${myconf} use_devil=1"
	# don't use MAKEOPTS - scons will eats whole memory
	scons prefix="${D}"/usr/ libdir="/usr/"$(get_libdir)/ ${myconf} || die
}

src_install() {
	scons prefix="${D}"/usr/ libdir="${D}"/usr/"$(get_libdir)/" \
		pkgconfigdir="${D}"/usr/lib/pkgconfig install || die
	for pcfile in GiGi GiGiOgre GiGiSDL; do
		sed -e "s:${D}:/:g" -i "${D}"/usr/lib/pkgconfig/${pcfile}.pc
	done
}

