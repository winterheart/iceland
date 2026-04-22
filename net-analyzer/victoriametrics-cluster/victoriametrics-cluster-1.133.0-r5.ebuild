# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Fast monitoring solution and time series database, cluster version"
HOMEPAGE="https://victoriametrics.com/"
SRC_URI="https://github.com/VictoriaMetrics/VictoriaMetrics/archive/refs/tags/v${PV}-cluster.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/VictoriaMetrics-${PV}-cluster"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	acct-group/victoriametrics
	acct-user/victoriametrics
"
BDEPEND=">=dev-lang/go-1.25.0"

src_compile() {
	local bin=( vmalert vmauth vminsert vmselect vmstorage )
	for i in "${bin[@]}" ; do
		CGO_ENABLED=1 ego build \
			-ldflags "-X 'github.com/VictoriaMetrics/VictoriaMetrics/lib/buildinfo.Version=$i-v${PV}'" \
			-o bin/${i} github.com/VictoriaMetrics/VictoriaMetrics/app/${i}
	done
}

src_install() {
	dodoc README.md

	local service=( vmauth vminsert vmselect vmstorage )
	for i in "${service[@]}" ; do
		dobin "bin/${i}"
		newinitd "${FILESDIR}/${i}.initd" "${i}"
		newconfd "${FILESDIR}/${i}.confd" "${i}"
	done
	dobin bin/vmalert
	insinto "/etc/victoriametrics"
	doins "${FILESDIR}/vmauth.yml"
	insinto "/etc/logrotate.d"
	newins "${FILESDIR}/victoriametrics-cluster.logrotate" victoriametrics-cluster
}
