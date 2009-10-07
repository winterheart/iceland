# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit confutils subversion webapp

DESCRIPTION="Flexible project management web application written using Ruby on Rails framework"
HOMEPAGE="http://www.redmine.org"
SRC_URI=""
ESVN_REPO_URI="http://redmine.rubyforge.org/svn/trunk/"

KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2"
#SLOT="0"
IUSE="cvs darcs git imagemagick mercurial mysql openid postgres sqlite3 subversion"

DEPEND="dev-ruby/rails:2.3
	dev-ruby/activerecord:2.2[mysql?,postgres?,sqlite3?]"

RDEPEND="${DEPEND}
	>=dev-ruby/ruby-net-ldap-0.0.4
	>=dev-ruby/coderay-0.7.6.227
	cvs? ( >=dev-util/cvs-1.12 )
	darcs? ( dev-util/darcs )
	git? ( dev-util/git )
	imagemagick? ( dev-ruby/rmagick )
	mercurial? ( dev-util/mercurial )
	openid? ( >=dev-ruby/ruby-openid-2 )
	subversion? ( >=dev-util/subversion-1.3 )"

pkg_setup() {
	webapp_pkg_setup
	confutils_require_any mysql postgres sqlite3
#	enewgroup redmine
	# home directory is required for SCM.
#	enewuser redmine -1 -1 -1 redmine
}

src_prepare() {
	rm -fr log files/delete.me
#	rm -fr vendor/plugins/actionwebservice
	rm -fr vendor/plugins/coderay-0.7.6.227
	rm -fr vendor/plugins/ruby-net-ldap-0.0.4
}

src_install() {
	webapp_src_preinst
	mv config/database.yml{.example,}
	mv config/email.yml{.example,}
	cp -R * "${D}/${MY_HTDOCSDIR}"
	dodir "${MY_HTDOCSDIR}"/{tmp,public/plugin_assets}
	webapp_serverowned -R ${MY_HTDOCSDIR}/{files,log,tmp,public/plugin_assets}
	fperms 0755 -R ${MY_HTDOCSDIR}/{files,log,tmp,public/plugin_assets}
	webapp_configfile "${MY_HTDOCSDIR}/config/database.yml"
	webapp_configfile "${MY_HTDOCSDIR}/config/email.yml"
	webapp_configfile "${MY_HTDOCSDIR}/config/settings.yml"
	webapp_postinst_txt en "${FILESDIR}"/${P}-postinst.en.txt

	webapp_src_install
}

