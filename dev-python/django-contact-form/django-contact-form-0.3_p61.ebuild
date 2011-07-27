# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
inherit distutils

#MY_P=contact_form

DESCRIPTION="An extensible contact-form application for Django"
HOMEPAGE="https://bitbucket.org/ubernostrum/django-contact-form/overview/"
# Upstream is lazy man. No updates since 2009.
# But I need fresh version!!
# Based on revision 61 (97559a887345) from Bitbucket
SRC_URI="http://ftp.gentoo.ru/people/winterheart/distfiles//${P}.tar.bz2"
LICENSE="BSD-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""
DEPEND=""
RDEPEND=""
