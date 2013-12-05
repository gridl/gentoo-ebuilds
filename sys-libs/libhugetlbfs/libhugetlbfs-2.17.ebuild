# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit eutils multilib toolchain-funcs

DESCRIPTION="libhugetlbfs interacts with the Linux hugetlbfs to make large pages available to applications in a transparent manner."
HOMEPAGE="http://sourceforge.net/projects/libhugetlbfs/"
SRC_URI="http://sourceforge.net/projects/libhugetlbfs/files/${PN}/${PVR}/${PN}-${PVR}.tar.gz"

LICENSE="LGPL"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

CONFIG_CHECK="~TRANSPARENT_HUGEPAGE ~HUGETLBFS ~HUGETLB_PAGE"

src_compile() {
	emake PREFIX=/usr LIB32=lib32 LIB64=lib64 || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install PREFIX=/usr LIB32=lib32 LIB64=lib64 || die "install failed"
}
