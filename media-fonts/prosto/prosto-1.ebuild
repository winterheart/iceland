# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit font

DESCRIPTION="Prosto font"
HOMEPAGE="http://www.behance.net/gallery/Prosto-font-%28FREE%29/3165360"
SRC_URI="http://jovanny.ru/fonts/Prosto.rar"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="X"

DEPEND="app-arch/unrar"
RDEPEND=""

S=${WORKDIR}
FONT_S=${WORKDIR}
FONT_SUFFIX="ttf"
