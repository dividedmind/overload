# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit cmake-multilib

DESCRIPTION="PulseAudio emulation for ALSA"
HOMEPAGE="https://github.com/i-rinat/apulse"
SRC_URI="https://github.com/i-rinat/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/alsa-lib
		dev-libs/glib:2
		!media-sound/pulseaudio
"
RDEPEND="${DEPEND}"

MULTILIB_CHOST_TOOLS=( /usr/bin/apulse )

multilib_src_configure() {
	local mycmakeargs=(-DAPULSEPATH="${EPREFIX}/usr/$(get_libdir)/apulse")
	cmake-utils_src_configure
}

multilib_src_test() {
	emake check
}

multilib_src_install() {
	cmake-utils_src_install "${_cmake_args[@]}"
	dodir "/usr/$(get_libdir)/apulse"
	if use amd64 && [ "${ABI}" == "x86" ]; then
		dosym "${CBUILD}-apulse" /usr/bin/apulse32
	fi
}
