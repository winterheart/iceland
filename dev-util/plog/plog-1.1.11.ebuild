# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Portable, simple and extensible C++ logging library"
HOMEPAGE="https://github.com/SergiusTheBest/plog"
SRC_URI="https://github.com/SergiusTheBest/plog/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE="test"
RESTRICT="!test? ( test )"

src_configure() {
	mycmakeargs=(
		"-DPLOG_BUILD_SAMPLES=OFF"
		"-DPLOG_BUILD_TESTS=$(usex test)"
		"-DPLOG_INSTALL=ON"
	)
	cmake_src_configure
}
