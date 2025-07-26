# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Horizontally scalable, highly available, long-term storage for Prometheus."
HOMEPAGE="https://grafana.com/oss/mimir/"
SRC_URI="https://github.com/grafana/mimir/archive/refs/tags/${P}.tar.gz"

S="${WORKDIR}/${PN}-${P}"

LICENSE="AGPL-3+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	acct-group/grafana
	acct-user/mimir
"
BDEPEND=">=dev-lang/go-1.24.2"

src_compile() {
	mkdir build || die

	local ldflags="-X github.com/grafana/mimir/pkg/util/version.Version=${PV}"
	ego build -v \
		-o build \
		-ldflags "$ldflags" \
		-tags "netgo,stringlabels" \
		./cmd/...
}

src_install() {
	dobin build/*

	insinto /etc/mimir
	doins "${FILESDIR}/mimir.yaml"

	newinitd "${FILESDIR}/mimir.initd" "mimir"
	newconfd "${FILESDIR}/mimir.confd" "mimir"

	dodoc README.md
}
