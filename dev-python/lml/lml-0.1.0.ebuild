# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )
inherit distutils-r1

DESCRIPTION="A lazy loading plugin management system"
HOMEPAGE="https://pypi.python.org/pypi/lml"
SRC_URI="https://github.com/chfw/lml/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
