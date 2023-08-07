# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit bash-completion-r1

DESCRIPTION="A fast distributed storage system ('large disk' version)"
HOMEPAGE="https://github.com/seaweedfs/seaweedfs"
SRC_URI="https://github.com/seaweedfs/seaweedfs/releases/download/${PV}/linux_amd64_large_disk.tar.gz -> ${PN}-linux_amd64_large_disk-${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="-* ~amd64"

S="${WORKDIR}"

src_install() {
	exeinto "/opt/${PN}"
	doexe weed
	dosym "/opt/${PN}/weed" "/usr/bin/weed"

	newbashcomp "${FILESDIR}/seaweedfs.bashcomp" weed

	for i in filer master ; do
		./weed scaffold -config ${i} -output ./ || die "Config generation failed"
		insinto /etc/seaweedfs
		doins ${i}.toml
	done
	for i in filer master volume ; do
		newconfd "${FILESDIR}/seaweedfs-${i}.confd" "seaweed-${i}"
		newinitd "${FILESDIR}/seaweedfs-${i}.initd" "seaweed-${i}"
	done
}
