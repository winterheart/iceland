# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
inherit eutils flag-o-matic toolchain-funcs multilib

MY_PN=FreeImage
MY_P=${MY_PN}${PV//.}
DESCRIPTION="Image library supporting many formats"
HOMEPAGE="http://freeimage.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.zip
	doc? ( mirror://sourceforge/${PN}/${MY_P}.pdf )"

LICENSE="|| ( GPL-2 FIPL-1.0 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cxx doc"

DEPEND="
	media-libs/jpeg
	media-libs/libmng
	media-libs/libpng
	media-libs/tiff
	sys-libs/zlib
	media-libs/openjpeg
	media-libs/openexr
	app-arch/unzip"
RDEPEND=""

S=${WORKDIR}/${MY_PN}

src_prepare() {
	append-cflags -std=c99 -D_POSIX_SOURCE # silence warnings from gcc
	epatch "${FILESDIR}"/${P}-system-{jpeg,openjpeg,libmng,libpng,openexr,zlib,makefile}.patch
}

src_compile() {
	emake -f Makefile.gnu || die "emake failed"
	if use cxx ; then
		emake -f Makefile.fip || die "emake fip failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" INSTALLDIR="${D}/usr/$(get_libdir)" \
		-f Makefile.gnu install || die
	if use cxx ; then
		emake DESTDIR="${D}" INSTALLDIR="${D}/usr/$(get_libdir)" \
			-f Makefile.fip install
	fi
	dodoc README.linux Whatsnew.txt
	use doc && dodoc "${DISTDIR}"/${MY_P}.pdf

	ebegin "Installing ${PN}.pc file"
	dodir /usr/$(get_libdir)/pkgconfig
	sed \
		-e "s:@LIBDIR@:$(get_libdir):" \
		-e "s:@PACKAGENAME@:${MY_PN}:" \
		-e "s:@DESCRIPTION@:${DESCRIPTION}:" \
		-e "s:@REQUIRES@:OpenEXR libpng:" \
		-e "s:@VERSION@:${PV}:" \
		-e "s:@LIBS@:-lfreeimage -lfreeimageplus:" \
		-e "s:@EXTLIBS@:-ljpeg -lmng -ltiff -lopenjpeg -lz:" \
		"${FILESDIR}/${PN}.pc.in" > "${D}/usr/$(get_libdir)/pkgconfig/${PN}.pc"	|| die
	eend $?
	PKG_CONFIG_PATH="${D}/usr/$(get_libdir)/pkgconfig/" pkg-config --exists ${PN} \
		|| die ".pc file failed to validate."
}
