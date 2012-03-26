# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/tesseract/tesseract-2.04-r1.ebuild,v 1.7 2010/11/20 11:37:09 armin76 Exp $

EAPI=4

inherit autotools

DESCRIPTION="An OCR Engine that was developed at HP and now at Google"
HOMEPAGE="http://code.google.com/p/tesseract-ocr/"
SRC_URI="http://tesseract-ocr.googlecode.com/files/${P}.tar.gz
	http://tesseract-ocr.googlecode.com/files/${PN}-ocr-${PV}.eng.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
#linguas_de linguas_eu linguas_es linguas_fr linguas_it linguas_nl linguas_pt_BR linguas_vi"

DEPEND="media-libs/leptonica"
RDEPEND="${DEPEND}"

# NOTES:
# english language files are always installed because they are used by default
#   that is a tesseract bug and if possible this workaround should be avoided
#   see bug 287373
# deu-f corresponds to an old german graphic style named fraktur
#   that's the same language (german, de)
# stuff in directory java/ seems useless...
# in testing/, there is a way to test accuracy, not usable for src_test()
# app-ocr/ would be a better category

src_prepare() {
	eautomake
}

src_install() {
	emake DESTDIR="${D}" install
	insinto /usr/share/tessdata
	doins ../tesseract-ocr/tessdata/*
	dodoc AUTHORS ChangeLog NEWS README ReleaseNotes
}
