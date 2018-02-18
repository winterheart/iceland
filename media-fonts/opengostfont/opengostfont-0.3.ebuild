# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit font

DESCRIPTION="Fonts by Russian standard GOST 2.304-81 'Letters for drawings'"
HOMEPAGE="https://bitbucket.org/fat_angel/opengostfont"
SRC_URI="https://bitbucket.org/fat_angel/${PN}/downloads/${PN}-ttf-${PV}.tar.xz"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="X"

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${PN}-ttf-${PV}"
#FONT_S=${WORKDIR}
FONT_SUFFIX="ttf"
