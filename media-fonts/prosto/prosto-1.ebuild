# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit font

DESCRIPTION="Prosto font"
HOMEPAGE="http://jovanny.ru/"
SRC_URI="http://jovanny.ru/files/fonts/prosto.zip"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="X"

DEPEND="app-arch/unzip"
RDEPEND=""

S="${WORKDIR}/Prosto"
FONT_S="${WORKDIR}/Prosto"
FONT_SUFFIX="ttf"
