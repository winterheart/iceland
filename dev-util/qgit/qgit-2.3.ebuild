# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/qgit/qgit-2.3.ebuild,v 1.1 2009/05/19 22:19:08 jokey Exp $

EAPI="2"

inherit qt4

MY_PV=${PV//_/}
MY_P=${PN}-${MY_PV}

DESCRIPTION="GUI interface for git/cogito SCM"
HOMEPAGE="http://digilander.libero.it/mcostalba/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug"

DEPEND="|| ( x11-libs/qt-gui:4 =x11-libs/qt-4.3*:4 )"
RDEPEND="${DEPEND}
	>=dev-util/git-1.5.3"

S="${WORKDIR}/${PN}"

src_compile() {
	eqmake4 || die "eqmake failed"
	emake || die "emake failed"
}

src_install() {
	newbin bin/qgit qgit4
	newicon src/resources/qgit.png qgit4.png
	make_desktop_entry qgit4 QGit qgit4.png
	dodoc README
}
