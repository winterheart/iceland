# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Fast monitoring solution and time series database, cluster version"
HOMEPAGE="https://victoriametrics.com/"
SRC_URI="https://github.com/VictoriaMetrics/VictoriaMetrics/archive/refs/tags/v${PV}-cluster.tar.gz -> ${P}-cluster.tar.gz"

S="${WORKDIR}/VictoriaMetrics-${PV}-cluster"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+agent +server tools"

RDEPEND="
	acct-group/victoriametrics
	acct-user/victoriametrics
"
BDEPEND=">=dev-lang/go-1.25.0"

src_compile() {
	local bin=( vmagent vmalert vmauth vmbackup vmctl vminsert vmrestore vmselect vmstorage )
	for i in "${bin[@]}" ; do
		CGO_ENABLED=1 ego build \
			-ldflags "-X 'github.com/VictoriaMetrics/VictoriaMetrics/lib/buildinfo.Version=${PV}'" \
			-o bin/${i} github.com/VictoriaMetrics/VictoriaMetrics/app/${i}
	done
}

src_install() {
	dodoc README.md

	if use server ; then
		local service=( vmauth vminsert vmselect vmstorage )
		for i in "${service[@]}" ; do
			dobin "bin/${i}"
			newinitd "${FILESDIR}/${i}.initd" "${i}"
			newconfd "${FILESDIR}/${i}.confd" "${i}"
		done
		dobin bin/vmalert
		insinto "/etc/victoriametrics"
		doins "${FILESDIR}/vmauth.yml"
	fi
	if use tools ; then
		local tool=( vmbackup vmctl vmrestore )
		for i in "${tool[@]}" ; do
			dobin "bin/${i}"
		done
	fi
	if use agent ; then
		local service=( vmagent )
		for i in "${service[@]}" ; do
			dobin "bin/${i}"
			newinitd "${FILESDIR}/${i}.initd" "${i}"
			newconfd "${FILESDIR}/${i}.confd" "${i}"
		done
	fi
}
