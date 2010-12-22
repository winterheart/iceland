# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit distutils

DESCRIPTION="Addon framework for Django."
HOMEPAGE="http://bitbucket.org/indifex/django-addons/"
SRC_URI="mirror://pypi/d/${PN}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-python/django-1.2.3"
RDEPEND="${DEPEND}"
