# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Deep ghidra decompiler and sleigh disassembler integration for rizin"
HOMEPAGE="https://github.com/rizinorg/rz-ghidra"
SRC_URI="https://github.com/rizinorg/rz-ghidra/releases/download/v${PV}/${PN}-src-v${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="${DEPEND}
	dev-util/cutter
	>=dev-util/rizin-0.8:="
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

src_configure() {
	mycmakeargs=(
		"-DBUILD_CUTTER_PLUGIN=ON"
		"-DCUTTER_INSTALL_PLUGDIR=/usr/share/rizin/cutter/plugins/native"
	)
	cmake_src_configure
}
