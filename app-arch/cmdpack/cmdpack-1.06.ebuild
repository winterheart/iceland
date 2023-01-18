# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Utilites from Neill Corlett, bin2ecm included"
HOMEPAGE="https://github.com/chungy/cmdpack"
SRC_URI="https://github.com/chungy/cmdpack/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="app-text/asciidoc"

src_prepare() {
	default

	sed -i -e "s:install-bin2iso::" -e "s:bin2iso::" Makefile
}

src_install() {
	emake prefix=/usr DESTDIR="${D}" install
	dodoc README.adoc
}
