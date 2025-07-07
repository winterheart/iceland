# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )
inherit distutils-r1

DESCRIPTION="A template for PostgreSQL HA with DCS"
HOMEPAGE="https://patroni.readthedocs.io/ https://github.com/zalando/patroni"
SRC_URI="https://github.com/zalando/patroni/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="aws consul +etcd raft zookeeper"
REQUIRED_USE="|| ( consul etcd raft zookeeper )"

RDEPEND="
	acct-group/postgres
	acct-user/postgres
	>=dev-python/click-4.1[${PYTHON_USEDEP}]
	>=dev-python/prettytable-0.7[${PYTHON_USEDEP}]
	>=dev-python/psutil-2.0.0[${PYTHON_USEDEP}]
	dev-python/psycopg:0[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	>=dev-python/python-json-logger-2.0.2[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	>=dev-python/six-1.7[${PYTHON_USEDEP}]
	>dev-python/urllib3-1.21[${PYTHON_USEDEP}]
	>=dev-util/ydiff-1.4.2[${PYTHON_USEDEP}]
	aws? ( dev-python/boto3[${PYTHON_USEDEP}] )
	consul? ( >=dev-python/py-consul-1.1.1[${PYTHON_USEDEP}] )
	etcd? ( >=dev-python/python-etcd-0.4.3[${PYTHON_USEDEP}] )
	raft? (
		>=dev-python/cryptography-1.4[${PYTHON_USEDEP}]
		>=dev-python/pysyncobj-0.3.8[${PYTHON_USEDEP}]
	)
	zookeeper? ( >=dev-python/kazoo-1.3.1[${PYTHON_USEDEP}] )
"
BDEPEND="
	test? (
		dev-python/mock[${PYTHON_USEDEP}]
	)"

distutils_enable_tests pytest
distutils_enable_sphinx docs --no-autodoc

python_install_all() {
	newdoc postgres0.yml patroni.yml
	keepdir /etc/patroni
	fowners postgres:postgres /etc/patroni
	fperms 0700 /etc/patroni

	insinto /etc/logrotate.d
	newins "${FILESDIR}/patroni.logrotate" patroni
	newinitd "${FILESDIR}/patroni.init" patroni
	newconfd "${FILESDIR}/patroni.conf" patroni

	distutils-r1_python_install_all
}
