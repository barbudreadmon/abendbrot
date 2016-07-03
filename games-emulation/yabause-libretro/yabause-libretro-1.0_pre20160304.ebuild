# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit libretro-core

DESCRIPTION="libretro implementation of Yabause. (Sega Saturn)"
HOMEPAGE="https://github.com/libretro/yabause"
SRC_URI="https://github.com/libretro/yabause/archive/4262e7993299da17de20893e2d6efcd04f3929f6.tar.gz -> ${P}.tar.gz"
RESTRICT="primaryuri"

S="${WORKDIR}/yabause-4262e7993299da17de20893e2d6efcd04f3929f6"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/libretro/yabause.git"
	KEYWORDS=""
else
	KEYWORDS="amd64 x86"
fi

LICENSE="GPL-2"
SLOT="0"

RDEPEND=""
DEPEND="${RDEPEND}"

S="${S}/libretro"

pkg_preinst() {
	if ! has_version "=${CATEGORY}/${PN}-${PVR}"; then
		first_install="1"
	fi
}

pkg_postinst() {
	if [[ "${first_install}" == "1" ]]; then
		elog ""
		elog "You should put the following optional files in your 'system_directory' folder:"
		elog "saturn_bios.bin (Saturn BIOS)"
		elog ""
		ewarn "This message will only be displayed once!"
		ewarn ""
	fi
}
