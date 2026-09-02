# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module shell-completion

DESCRIPTION="A fast distributed storage system ('large disk' version)"
HOMEPAGE="https://github.com/seaweedfs/seaweedfs"
SRC_URI="https://github.com/seaweedfs/seaweedfs/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	https://repos.s3.m9.lfstrm.tv/gentoo/distfiles/${P}-vendor.tar.xz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND=">=dev-lang/go-1.25.8:="
RDEPEND="!sys-cluster/seaweedfs-bin"

src_compile() {
	ego build -tags production,5BytesOffset -o weed/weed ./weed
}

src_install() {
	dobin weed/weed
	newbashcomp "${FILESDIR}/seaweedfs.bashcomp" weed

	for i in admin filer master ; do
		weed/weed scaffold -config ${i} -output ./ || die "Config generation failed"
		insinto /etc/seaweedfs
		doins ${i}.toml
	done

	weed/weed scaffold -config=security -output ./ || die "Config generation failed"
	insinto /etc/seaweedfs
	doins security.toml

	for i in admin filer master sync volume worker ; do
		newconfd "${FILESDIR}/seaweedfs-${i}.confd-v2" "seaweed-${i}"
		newinitd "${FILESDIR}/seaweedfs-${i}.initd-v2" "seaweed-${i}"
	done

	elog "Be sure edit /etc/seaweedfs/security.toml for your needs."
	elog "See https://github.com/seaweedfs/seaweedfs/wiki/Security-Overview for the reference."
}
