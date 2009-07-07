# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils autotools

IUSE="amrnb doc gsm h323 ilbc mysql postgres ssl speex qt4 zaptel"

DESCRIPTION="YATE - Yet Another Telephony Engine"
HOMEPAGE="http://yate.null.ro/"
SRC_URI="http://yate.null.ro/tarballs/yate2/${P}-1.tar.gz"

S="${WORKDIR}"/${PN}

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"

DEPEND="media-sound/sox
	amrnb? ( media-libs/amrnb )
	speex? ( >=media-libs/speex-1.2_beta2 )
	zaptel? ( >=net-libs/libpri-1.0.0
	          >=net-misc/zaptel-1.0.0 )
	h323? ( >=net-libs/openh323-1.15.3 )
	mysql? ( virtual/mysql )
	qt4? ( x11-libs/qt-gui:4 )
	openssl? ( dev-libs/openssl )
	gsm? ( media-sound/gsm )
	doc? ( >=dev-util/kdoc-2.0_alpha54 )
	postgres? ( virtual/postgresql-server )"

RDEPEND=$DEPEND

RESTRICT="test"		# Test does not lauch unit tests

src_prepare() {
	sed -i -e '/^Exec=yate-qt4$/a Icon=null_team-32.png' \
		clients/yate-qt4.desktop || die "sed failed"
	# fix makefiles for custom CFLAGS/LDFLAGS
#	epatch "${FILESDIR}"/${P}-makefiles.patch
#	epatch "${FILESDIR}"/${P}-resolv.patch #199222

	eautoconf
}

src_configure() {
	econf \
		$(use_with amrnb amrnb /usr) \
		$(use_with h323 openh323 /usr) \
		$(use_with h323 pwlib /usr) \
		$(use_enable zaptel) \
		$(use_with gsm libgsm) \
		$(use_with mysql mysql /usr) \
		$(use_with ssl openssl) \
		$(use_with postgres libpq /usr) \
		$(use_with speex libspeex) \
		$(use_with qt4 libqt4) \
		$(use_enable ilbc) \
		|| die "Configure failed"
}

src_compile() {
	emake || die "Building failed"

	if use doc; then
		emake apidocs || die "Building of API docs failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install-noapi || die "emake install failed"

	newinitd "${FILESDIR}/yate.rc6" yate
	newconfd "${FILESDIR}/yate.confd" yate

	# install standard docs...
	dodoc README ChangeLog docs/*.html

	# install api docs
	if use doc; then
		docinto api
		dodoc docs/api/*.html
	fi
}
