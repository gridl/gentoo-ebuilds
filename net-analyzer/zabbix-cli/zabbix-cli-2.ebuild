# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit eutils

DESCRIPTION="Zabbix API interaction tool"
HOMEPAGE="https://github.com/lesovsky/zabbix-cli"
ZBX_EXT_GIT_SHA1="79d2701"
SRC_URI="https://github.com/lesovsky/zabbix-cli/tarball/${ZBX_EXT_GIT_SHA1} -> ${P}.tar.gz"
S="${WORKDIR}/lesovsky-${PN}-${ZBX_EXT_GIT_SHA1}"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

DEPEND="net-misc/curl"
RDEPEND="${DEPEND}"

src_install() {
        insinto /etc/${PN}
        doins etc/${PN}.conf
		fperms 600 /etc/${PN}/${PN}.conf

		insinto /usr/lib64/${PN}
        doins -r lib/*
        
        exeinto /usr/libexec/${PN}
        doexe bin/*

        dosym /usr/libexec/${PN}/${PN} /usr/bin/${PN}
}
