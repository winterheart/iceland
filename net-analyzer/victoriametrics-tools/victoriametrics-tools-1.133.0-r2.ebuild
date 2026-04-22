# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Additional tools for VictoriaMetrics"
HOMEPAGE="https://victoriametrics.com/"
SRC_URI="https://github.com/VictoriaMetrics/VictoriaMetrics/archive/refs/tags/v${PV}-cluster.tar.gz -> victoriametrics-cluster-${PV}.tar.gz"

S="${WORKDIR}/VictoriaMetrics-${PV}-cluster"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND=">=dev-lang/go-1.25.0"

src_compile() {
	local bin=( vmbackup vmctl vmrestore )
	for i in "${bin[@]}" ; do
		CGO_ENABLED=1 ego build \
			-ldflags "-X 'github.com/VictoriaMetrics/VictoriaMetrics/lib/buildinfo.Version=${PV}'" \
			-o bin/${i} github.com/VictoriaMetrics/VictoriaMetrics/app/${i}
	done
}

src_install() {
	dodoc README.md

	local tool=( vmbackup vmctl vmrestore )
	for i in "${tool[@]}" ; do
		dobin "bin/${i}"
	done
}
