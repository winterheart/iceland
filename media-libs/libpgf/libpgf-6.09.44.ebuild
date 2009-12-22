# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit autotools

DESCRIPTION="Library to load, handle and manipulate images in the PGF format"

HOMEPAGE="http://www.libpgf.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="doc? ( app-doc/doxygen )
	app-arch/unzip"
RDEPEND=""

S="${WORKDIR}"/${PN}

src_prepare() {
	if use !doc; then
		sed -i \
		-e "s/\(SUBDIRS = src include\) doc/\1/g" Makefile.am || die "sed failed"
	fi

	sed -i \
		-e "s/exec_prefix=@prefix@/exec_prefix=@exec_prefix@/" \
		-e "s/libdir=@prefix@\/lib/libdir=@libdir@/" \
		-e "s/includedir=@prefix@\/include/includedir=@includedir@/" \
			libpgf.pc.in || die "sed failed"
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc README
}

