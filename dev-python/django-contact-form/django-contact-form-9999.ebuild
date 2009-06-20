# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit distutils mercurial

MY_P=contact_form

DESCRIPTION="An extensible contact-form application for Django"
# Now in Bitbucket
HOMEPAGE="http://bitbucket.org/ubernostrum/django-contact-form/"

EHG_REPO_URI="http://bitbucket.org/ubernostrum/django-contact-form/"

LICENSE="BSD-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""
DEPEND=""
RDEPEND=""

S="${WORKDIR}/${PN}"
