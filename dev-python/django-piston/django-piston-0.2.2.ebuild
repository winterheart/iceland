# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# Ebuild generated by g-pypi 0.2.1 (rev. 204)

inherit distutils

DESCRIPTION="Piston is a Django mini-framework creating APIs."
HOMEPAGE="http://bitbucket.org/jespern/django-piston/wiki/Home"
SRC_URI="http://bitbucket.org/jespern/django-piston/downloads/${P}.tar.gz"
LICENSE="BSD-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND=">=dev-python/django-1.0"

S="${WORKDIR}/${PN}"

src_test() {
	PYTHONPATH=. "${python}" setup.py test || die "tests failed"
}
