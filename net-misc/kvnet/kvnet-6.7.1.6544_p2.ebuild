# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit linux-mod versionator

MY_PV=$(replace_version_separator 3 '-')
MY_PV=${MY_PV/_p/\.T}

DESCRIPTION="Kernel driver for Kerio VPN Client"
HOMEPAGE="http://www.kerio.com/kwf_vpn.html"
SRC_URI="http://download.kerio.com/dwn/kwf/${PN}_${MY_PV}.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/drivers/vpn/linux"

MODULE_NAMES="kvnet(net:${S}:${S})"
BUILD_PARAMS="-C /lib/modules/${KV}/build SUBDIRS=${S}"
BUILD_TARGETS="modules"
