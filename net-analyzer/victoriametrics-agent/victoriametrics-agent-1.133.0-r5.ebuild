# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="vmagent for VictoriaMetrics"
HOMEPAGE="https://victoriametrics.com/"
SRC_URI="https://github.com/VictoriaMetrics/VictoriaMetrics/archive/refs/tags/v${PV}-cluster.tar.gz -> victoriametrics-cluster-${PV}.tar.gz"

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
	local bin=( vmagent )
	for i in "${bin[@]}" ; do
		CGO_ENABLED=1 ego build \
			-ldflags "-X 'github.com/VictoriaMetrics/VictoriaMetrics/lib/buildinfo.Version=$i-v${PV}'" \
			-o bin/${i} github.com/VictoriaMetrics/VictoriaMetrics/app/${i}
	done
}

src_install() {
	dodoc README.md

	local service=( vmagent )
	for i in "${service[@]}" ; do
		dobin "bin/${i}"
		newinitd "${FILESDIR}/${i}.initd" "${i}"
		newconfd "${FILESDIR}/${i}.confd" "${i}"
	done
	insinto "/etc/logrotate.d"
	newins "${FILESDIR}/victoriametrics-agent.logrotate" victoriametrics-agent
}
