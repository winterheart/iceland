# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit autotools games

EAPI="2"

DESCRIPTION="A portable open-source implementation of Bioware's Infinity Engine"
HOMEPAGE="http://linux.prinas.si/gemrb/"
SRC_URI="mirror://sourceforge/gemrb/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc zlib"

DOCS="AUTHORS README gemrb/GemRB.cfg.sample"

RDEPEND="media-libs/libvorbis
		dev-lang/python
		zlib? ( sys-libs/zlib )"

DEPEND="${DEPEND}
		media-libs/openal
		media-libs/libsdl
		media-libs/libpng"

src_prepare() {
	sed -i '/sysconf_DATA = GemRB.cfg.sample GemRB.cfg.subdir.sample/d' \
			gemrb/Makefile.am || die "sed failed"
	if ! use doc ; then
		sed -i 's|^SUBDIRS = \(.*\) docs|SUBDIRS = \1|' \
			gemrb/Makefile.am || die "sed failed"
	fi
	eautoreconf || die "eautoreconf failed"
}

src_configure() {
	local myconf="--docdir=/usr/share/doc/${PN}"
	use !zlib && myconf="${myconf} --without-zlib"
	egamesconf "${myconf}"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	diropts -m0775 -g ${GAMES_GROUP}
	keepdir "/var/cache/gemrb"
	prepgamesdirs
}

