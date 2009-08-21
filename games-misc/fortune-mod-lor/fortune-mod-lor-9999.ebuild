# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Famous quotes from Linux.Org.Ru"
HOMEPAGE="http://lorquotes.ru/"
SRC_URI=""

LICENSE="as-is"
SLOT="0"
KEYWORDS=""
IUSE="unicode"

RDEPEND="games-misc/fortune-mod"
DEPEND="${RDEPEND}
	unicode? ( virtual/libiconv )"

S="${WORKDIR}"

src_unpack() {
	wget http://www.lorquotes.ru/fortraw.php -O "${S}"/lor
}

src_compile() {
	sed -i -e 's/\&lt;/\</'g "${S}"/lor || die sed failed
	if use unicode ; then
		iconv --from-code koi8-r --to-code utf8 -o lor.utf8 lor || die "iconv failed"
		mv lor.utf8 lor
	fi
	strfile -s lor || die "strfile failed"
}

src_install() {
	insinto /usr/share/fortune
	doins lor lor.dat || die "doins failed"
}
