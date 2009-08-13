# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit distutils

DESCRIPTION="South provides intelligent schema migrations for Django apps."
HOMEPAGE="http://south.aeracode.org/"
SRC_URI="http://www.aeracode.org/releases/south/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=">=dev-python/django-1.0"

S=${WORKDIR}/${PN}

src_install(){
	distutils_src_install
	elog "In order to use the south schema migrations for your Django project,"
	elog "just add 'south' to your INSTALLED_APPS in the settings.py file."
	elog "manage.py will now automagically offer the new functions."
}

