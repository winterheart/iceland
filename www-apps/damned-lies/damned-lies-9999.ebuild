# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit distutils git multilib

DESCRIPTION="Web application for translation tracking"
HOMEPAGE="http://git.gnome.org/cgit/damned-lies/"

GIT_REPO_URI="http://code.transifex.org/mainline"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="0"

IUSE="debug evolution mysql openid postgres sqlite"
DEPEND="dev-python/setuptools
	dev-python/django[mysql?,sqlite?,postgres?]"

RDEPEND=">=dev-python/django-1.0
	debug? ( dev-python/django-debug-toolbar )
	evolution? ( dev-python/django-evolution )
	openid? ( dev-python/django-openid
			dev-python/python-openid )"

#src_compile() {
#	distutils_src_compile
#}

src_install() {
	distutils_src_install

#	fperms 0755	/usr/$(get_libdir)/python${PYVER}/site-packages/transifex/manage.py
}

#pkg_postinst() {
#
#}

