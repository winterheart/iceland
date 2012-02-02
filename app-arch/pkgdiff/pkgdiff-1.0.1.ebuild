# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Package Changes Analyzer is a tool for analyzing changes in Linux software packages"
HOMEPAGE="http://pkgdiff.github.com/pkgdiff/"
SRC_URI="https://github.com/downloads/${PN}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dpkg rpm"

DEPEND=""
RDEPEND="dev-lang/perl
	app-text/wdiff
	sys-apps/gawk
	sys-devel/binutils
	dpkg? ( app-arch/dpkg )
	rpm? ( app-arch/rpm )"

src_install() {
	newbin pkgdiff.pl pkgdiff
	insinto /usr/share/pkgdiff
	doins -r modules
	dodoc README
	dohtml doc/Readme.html
}
