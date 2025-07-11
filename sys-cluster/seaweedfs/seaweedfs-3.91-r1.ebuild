# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit bash-completion-r1 go-module

DESCRIPTION="A fast distributed storage system ('large disk' version)"
HOMEPAGE="https://github.com/seaweedfs/seaweedfs"
SRC_URI="https://github.com/seaweedfs/seaweedfs/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	https://repos.s3.m9.lfstrm.tv/gentoo/distfiles/${P}-vendor.tar.xz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND=">=dev-lang/go-1.24:="
RDEPEND="!sys-cluster/seaweedfs-bin"

PATCHES=(
	"${FILESDIR}/seaweedfs-3.91-mongodb-fix.patch"
)

src_compile() {
	ego build -tags production,5BytesOffset -o weed/weed ./weed
}

src_install() {
	dobin weed/weed
	newbashcomp "${FILESDIR}/seaweedfs.bashcomp" weed

	for i in filer master ; do
		weed/weed scaffold -config ${i} -output ./ || die "Config generation failed"
		insinto /etc/seaweedfs
		doins ${i}.toml
	done
	for i in filer master sync volume ; do
		newconfd "${FILESDIR}/seaweedfs-${i}.confd" "seaweed-${i}"
		newinitd "${FILESDIR}/seaweedfs-${i}.initd" "seaweed-${i}"
	done
}
