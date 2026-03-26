# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Prometheus Exporter for Postfix"
HOMEPAGE="https://github.com/Hsn723/postfix_exporter"
SRC_URI="
	https://github.com/Hsn723/postfix_exporter/releases/download/v${PV}/${P}.tar.gz
	https://repos.s3.m9.lfstrm.tv/gentoo/distfiles/${P}-deps.tar.xz
"

S="${WORKDIR}"

LICENSE="Apache-2.0 BSD MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="systemd"
RESTRICT+=" test"

RDEPEND="
	acct-group/postfix_exporter
	acct-user/postfix_exporter
"
DEPEND="${RDEPEND}
	systemd? ( sys-apps/systemd )
"

src_compile() {
	ego build -tags "$(usex systemd '' 'nosystemd'),nodocker,nokubernetes" -v -o bin/${PN}
}

src_install() {
	dobin bin/${PN}
	dodoc README.md
	newinitd "${FILESDIR}"/${PN}.initd ${PN}
	newconfd "${FILESDIR}"/${PN}.confd ${PN}
	insinto /etc/logrotate.d
	newins "${FILESDIR}/${PN}.logrotated" "${PN}"
}
