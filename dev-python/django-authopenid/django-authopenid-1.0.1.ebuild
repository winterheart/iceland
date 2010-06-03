# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# Ebuild generated by g-pypi 0.2.1 (rev. 204)

inherit distutils

DESCRIPTION="Openid authentification application for Django"
HOMEPAGE="http://hg.e-engura.org/django-authopenid/"
SRC_URI="http://pypi.python.org/packages/source/d/${PN}/${P}.tar.gz"
LICENSE="BSD-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""
DEPEND="dev-python/setuptools"
RDEPEND=">=dev-python/python-openid-2.2.1
	dev-python/django-registration"
