# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"
inherit subversion eutils

DESCRIPTION="Redmine is a flexible project management web application written using Ruby on Rails framework"
HOMEPAGE="http://www.redmine.org/"
# SRC_URI=""
ESVN_REPO_URI="http://${PN}.rubyforge.org/svn/trunk/"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE="cvs darcs git imagemagick +mysql postgres sqlite3 subversion"

DEPEND="virtual/ruby
	>=dev-ruby/rubygems-0.9.4
	dev-ruby/rails:2.1
	dev-ruby/coderay
	www-servers/mongrel
	imagemagick? ( dev-ruby/rmagick )
	dev-ruby/ruby-net-ldap
"
RDEPEND="${DEPEND}
	cvs? ( >=dev-util/cvs-1.12 )
	darcs? ( dev-util/darcs )
	git? ( dev-util/git )
	mercurial? ( dev-util/mercurial )
	subversion? ( >=dev-util/subversion-1.3 )
"

pkg_setup() {
	if ! use mysql && ! use postgres && ! use sqlite3 ; then
		eerror "You must select at least one database backend, by enabling"
		eerror "at least one of the 'mysql', 'postgres' or 'sqlite3' USE flags."
		die "no database backend selected"
	fi

	if use mysql && ! built_with_use dev-ruby/activerecord mysql ; then
		eerror "You must compile activerecord with the mysql USE flag enabled"
		die
	fi
	if use postgres && ! built_with_use dev-ruby/activerecord postgres ; then
		eerror "You must compile activerecord with the postgresql USE flag enabled"
		die
	fi
	if use sqlite3 && ! built_with_use dev-ruby/activerecord sqlite3 ; then
		eerror "You must compile activerecord with the sqlite3 USE flag enabled"
		die
	fi
	enewgroup redmine
	enewuser  redmine -1 -1 -1 redmine
}

src_install() {
	dodoc doc/UPGRADING
	dodoc doc/INSTALL
	# Убираем ненужное
	rm -fr doc
	rm -fr vendor/plugins/coderay*
	rm -fr vendor/plugins/ruby-net-ldap*
	# Gentoo сам сможет с этим управиться
	mv "config/database.yml.example" "config/database.yml"
	mv "config/email.yml.example" "config/email.yml"

	keepdir "/var/lib/${PN}"
	dodir "/etc/${PN}"

	# Делаем конфиги в нужном месте
	insinto "/etc/${PN}"

	insinto "/var/lib/${PN}"
	keepdir "/var/lib/${PN}/files"
	doins -r .
	dodir tmp
	# Каталоги которые нужны для работы
	for x in files log tmp ; do
		fowners -R redmine:redmine "/var/lib/${PN}/${x}"
		fperms 755 "/var/lib/${PN}/${x}"
	done
	# Gentoo сам сможет с этим управиться
	for x in database.yml email.yml settings.yml ; do
		mv "${D}/var/lib/${PN}/config/${x}" "${D}/etc/${PN}/${x}"
		dosym "/etc/${PN}/${x}" "/var/lib/${PN}/config/${x}"
	done

	newconfd "${FILESDIR}/redmine.confd" redmine
	newinitd "${FILESDIR}/redmine.initd" redmine
}

pkg_postinst() {
	einfo "Installation notes can be found on official site"
	einfo "http://www.redmine.org/wiki/redmine/RedmineInstall"
	einfo ""
	einfo "Upgrade from previous version can be found on official site"
	einfo "http://www.redmine.org/wiki/redmine/RedmineUpgrade"
}
