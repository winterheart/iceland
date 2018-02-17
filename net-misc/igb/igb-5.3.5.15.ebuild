# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit linux-mod

DESCRIPTION="Driver for various Intel Gigabit network adapters"
HOMEPAGE="https://sourceforge.net/projects/e1000/"
SRC_URI="mirror://sourceforge/e1000/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

MODULE_NAMES="igb(net:${S}/src:${S}/src)"
BUILD_TARGETS="default"

CONFIG_CHECK="DCA"
ERROR_DCA="${P} requires Direct Cache Access (CONFIG_DCA) enabled"

src_install() {
	linux-mod_src_install
	dodoc README
	doman ${PN}.7
}
