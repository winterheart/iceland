# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Package Changes Analyzer for analyzing changes in Linux software packages"
HOMEPAGE="https://lvc.github.io/pkgdiff/"
SRC_URI="https://github.com/lvc/pkgdiff/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="abi dpkg rpm"

DEPEND=""
RDEPEND="dev-lang/perl
	app-text/wdiff
	sys-apps/diffutils
	sys-apps/gawk
	sys-devel/binutils
	abi? (
		dev-util/abi-compliance-checker
		dev-util/abi-dumper
	)
	dpkg? ( app-arch/dpkg )
	rpm? ( app-arch/rpm )"

DOCS=( README doc/Readme.html )

src_compile() {
	:;
}
src_install() {
	mkdir "${D}/usr/"
	perl Makefile.pl -install --prefix=/usr --destdir="${D}" || die
	dodoc README doc/Readme.html
}
