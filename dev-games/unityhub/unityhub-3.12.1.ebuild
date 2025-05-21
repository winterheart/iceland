# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop rpm xdg wrapper

DESCRIPTION="Official Unity Hub application"
HOMEPAGE="https://unity.com/"
SRC_URI="https://hub.unity3d.com/linux/repos/rpm/stable/unityhub_x86_64/${PN}-x86_64-${PV}.rpm"

LICENSE="CC0-1.0"
SLOT="0"
KEYWORDS="-* ~amd64"

QA_PREBUILT="*"
RESTRICT="bindist mirror strip"

RDEPEND="
	app-accessibility/at-spi2-core
	x11-libs/gtk+:3
	x11-libs/libnotify
	x11-libs/libXScrnSaver
	x11-libs/libXtst
	dev-libs/nss
	x11-misc/xdg-utils
"

S="${WORKDIR}"

src_install() {
	dodir /opt
	cp -a opt/unityhub "${ED}/opt" || die

	domenu usr/share/applications/unityhub.desktop
	doicon usr/share/icons/hicolor/64x64/apps/unityhub.png

	make_wrapper unityhub /opt/unityhub/unityhub /opt/unityhub
}
