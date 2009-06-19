# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit games subversion

EAPI=2

DESCRIPTION="An open-source galactic conquest game in the tradition of the Master of Orion games"

HOMEPAGE="http://www.freeorion.org/"
#SRC_URI=""
# actual 0.3.11
#ESVN_REPO_URI="http://${PN}.svn.sourceforge.net/svnroot/${PN}/trunk/FreeOrion/@2732"
ESVN_REPO_URI="http://${PN}.svn.sourceforge.net/svnroot/${PN}/trunk/FreeOrion"

# avoid to download shipped gigi
#ESVN_OPTIONS="--ignore-externals"


LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="
	dev-lang/python
	media-gfx/graphviz
	media-libs/freealut
	>=media-libs/libogg-1.1.3
	media-libs/openal
	media-libs/libvorbis
	dev-games/ogre[cg]
	=media-libs/gigi-9999
	sci-physics/bullet
"

DEPEND="${RDEPEND}
	dev-util/scons
"

src_compile() {
	# don't use MAKEOPTS, scons eats memory like a pig :)
	scons "release=yes" || die
}

src_install() {
	dogamesbin freeoriond
	dogamesbin freeorion freeoriond freeorionca
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r default || die "doins -r failed"
}

