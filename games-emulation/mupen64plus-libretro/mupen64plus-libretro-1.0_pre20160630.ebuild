# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit libretro-core

DESCRIPTION="libretro implementation of mupen64plus (Nintendo64)"
HOMEPAGE="https://github.com/libretro/mupen64plus-libretro"
SRC_URI="https://github.com/libretro/mupen64plus-libretro/archive/eb8f3d591bfa020cf4b7768e1b7efb36a4d1ec9a.tar.gz -> ${P}.tar.gz"
RESTRICT="primaryuri"

S="${WORKDIR}/mupen64plus-libretro-eb8f3d591bfa020cf4b7768e1b7efb36a4d1ec9a"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="git://github.com/libretro/mupen64plus-libretro.git"
	KEYWORDS=""
else
	KEYWORDS="amd64 x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="gles2"

DEPEND="media-libs/mesa:0=
		gles2? ( media-libs/mesa[gles2] )"
RDEPEND="${DEPEND}"

src_compile() {
	#this one could get some love from arm owners
	myemakeargs=(
		$(usex amd64 "WITH_DYNAREC=x86_64" "")
		$(usex x86 "WITH_DYNAREC=x86" "")
		$(usex arm "platform=rpi WITH_DYNAREC=arm" "")
		$(usex arm64 "platform=rpi WITH_DYNAREC=arm" "")
		$(usex gles2 "GLES=1" "")
	)
	emake "${myemakeargs[@]}" || die "emake failed"
}
