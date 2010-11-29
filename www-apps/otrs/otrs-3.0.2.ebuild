# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils confutils webapp
WEBAPP_MANUAL_SLOT="yes"

DESCRIPTION="OTRS is an Open source Ticket Request System"
HOMEPAGE="http://otrs.org/"
SRC_URI="http://ftp.otrs.org/pub/${PN}/${P}.tar.bz2"

LICENSE="AGPL-3"
KEYWORDS="~amd64 ~x86"
IUSE="apache2 cjk fastcgi +gd ldap mod_perl +mysql pdf postgres soap"
SLOT="3.0.2"

# add oracle/mssql/DB2 DB support 
DEPEND=""
RDEPEND="${DEPEND}
	dev-perl/Authen-SASL
	dev-perl/Crypt-PasswdMD5
	dev-perl/CSS-Minifier
	dev-perl/Date-Pcalc
	mysql? ( dev-perl/DBD-mysql )
	dev-perl/DBI
	cjk? ( >=dev-perl/Encode-HanExtra-0.23 )
	gd? ( dev-perl/GD
		dev-perl/GDTextUtil
		dev-perl/GDGraph )
	dev-perl/IO-Socket-SSL
	>=dev-perl/JavaScript-Minifier-1.05
	>=dev-perl/JSON-2.21
	dev-perl/JSON-XS
	dev-perl/LWP-UserAgent-Determined
	dev-perl/Mail-POP3Client
	dev-perl/MailTools
	>=dev-perl/MIME-tools-5.427
	dev-perl/Net-IMAP-Simple
	dev-perl/Net-IMAP-Simple-SSL
	>dev-perl/Net-DNS-0.60
	dev-perl/Net-SMTP-SSL
	dev-perl/Net-SMTP-TLS
	dev-perl/IO-stringy
	pdf? ( >=dev-perl/PDF-API2-0.73
		virtual/perl-Compress-Raw-Zlib )
	ldap? ( dev-perl/perl-ldap )
	soap? (
		dev-perl/SOAP-Lite
		!=dev-perl/SOAP-Lite-0.711
		!=dev-perl/SOAP-Lite-0.712 )
	dev-perl/Text-CSV
	dev-perl/Text-CSV_XS
	dev-perl/TimeDate
	dev-perl/XML-Parser

	virtual/perl-MIME-Base64
	>=virtual/perl-CGI-3.33
	virtual/perl-libnet
	virtual/perl-Digest-MD5
	>=virtual/perl-Digest-SHA-5.48

	virtual/mta

	apache2? ( mod_perl? ( www-servers/apache:2
					=www-apache/libapreq2-2* www-apache/mod_perl )
		fastcgi? ( || ( www-apache/mod_fcgid www-apache/mod_fastcgi )
				www-servers/apache:2[suexec] )
		!fastcgi? (
			!mod_perl? ( www-servers/apache:2[suexec] ) )
			)
	fastcgi? ( dev-perl/FCGI virtual/httpd-fastcgi )
	!fastcgi? (
		!apache2? ( virtual/httpd-cgi ) )"
#	postgres? ( dev-perl/DBD-Pg )
#   dev-perl/libwww-perl

pkg_setup() {

	webapp_pkg_setup

	if use apache2; then
		enewuser otrs -1 -1 /dev/null apache
	fi

	confutils_require_any postgres mysql
	confutils_use_depend_all mod_perl apache2
}

src_prepare() {
	cp Kernel/Config.pm{.dist,} || die

	cd ./Kernel/Config/ || die
	for i in *.dist; do
		cp ${i} $(basename ${i} .dist) || die
	done

	rm -fr "${S}/scripts"/{auto_*, redhat*, suse*, *.spec} || die

	if use fastcgi; then
		cd "${S}" || die
		epatch "${FILESDIR}"/apache2-3.0.patch
		sed -e "s|cgi-bin|fcgi-bin|" \
						-i scripts/apache2-httpd.include.conf || die
	fi
}

src_install() {
	webapp_src_preinst

	dodir "${MY_HOSTROOTDIR}"/${PF}
	dodoc CHANGES CREDITS INSTALL README* TODO UPGRADING \
	 	doc/otrs-database.dia  doc/X-OTRS-Headers.txt \
		.fetchmailrc.dist .mailfilter.dist .procmailrc.dist || die

	#dohtml doc/manual/{en,de}/html/*

	insinto "${MY_HOSTROOTDIR}/${PF}"
	doins -r .fetchmailrc.dist .mailfilter.dist .procmailrc.dist RELEASE \
			Kernel bin scripts var || die "doins failed"

	mv "${D}/${MY_HOSTROOTDIR}/${PF}/var/httpd"/htdocs/* \
								"${D}/${MY_HTDOCSDIR}" || die "mv failed"
	rm -rf "${D}/${MY_HOSTROOTDIR}/${PF}"/var/httpd || die

	for a in "article log pics/images pics/stats pics sessions spool tmp tmp/CacheFileStorable"; do
		keepdir "${MY_HOSTROOTDIR}/${PF}/var/${a}"
	done

	webapp_configfile "${MY_HOSTROOTDIR}/${PF}"/Kernel/Config.pm
	webapp_postinst_txt en "${FILESDIR}"/postinstall-en-2.txt
#	webapp_postinst_txt ru "${FILESDIR}"/postinstall-ru-2.txt
	webapp_hook_script "${FILESDIR}"/reconfig-3
	webapp_src_install
}

pkg_postinst() {
	ewarn "webapp-config will not be run automatically"
	ewarn "That messes up Apache configs"
	ewarn "Don't run webapp-config with -d otrs. Instead, try"
	ewarn "webapp-config -I -h <host> -d ot ${PN} ${PVR}"
	ewarn

	if ! use apache2; then
		ewarn "You did not activate the USE-flag apache2 which means you"
		ewarn "will need to create the otrs user yourself. Make this user"
		ewarn "a member of your webserver group."
	fi
	webapp_pkg_postinst
}
