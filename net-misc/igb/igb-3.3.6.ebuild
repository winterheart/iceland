# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit linux-mod

DESCRIPTION="Driver for various Intel Gigabit network adapters"
HOMEPAGE="http://sourceforge.net/projects/e1000/"
SRC_URI="mirror://sourceforge/e1000/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

MODULE_NAMES="igb(net:${S}/src:${S}/src)"
BUILD_TARGETS="modules"

src_compile() {
	BUILD_PARAMS="-C /lib/modules/${KV_FULL}/build SUBDIRS=${S}/src"
	linux-mod_src_compile
}

src_install() {
	linux-mod_src_install
	dodoc README
	doman ${PN}.7
}
