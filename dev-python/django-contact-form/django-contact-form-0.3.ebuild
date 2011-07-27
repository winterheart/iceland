# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
inherit distutils

MY_P=contact_form

DESCRIPTION="An extensible contact-form application for Django"
# Now in Bitbucket
HOMEPAGE="http://code.google.com/p/django-contact-form/"
SRC_URI="http://django-contact-form.googlecode.com/files/${MY_P}-${PV}.tar.gz"
LICENSE="BSD-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""
DEPEND=""
RDEPEND=""

S="${WORKDIR}/${MY_P}-${PV}"
