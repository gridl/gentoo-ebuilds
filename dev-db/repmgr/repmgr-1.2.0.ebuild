# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/repmgr/repmgr-9999.ebuild,v 1.1
# 2012/09/10 15:10:25 uu Exp $
EAPI=4

inherit eutils

DESCRIPTION="PostgreSQL Replication Manager"

HOMEPAGE="http://www.repmgr.org/"
SRC_URI="http://www.repmgr.org/download/${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

RDEPEND=">=dev-db/postgresql-base-9.0
		>=dev-db/postgresql-server-9.0
		virtual/pam
        dev-libs/libxslt
        net-misc/rsync"
DEPEND=""

src_compile() {
	make USE_PGXS=1
}

src_install() {
	export PGSLOT="$(postgresql-config show)"
	einfo "PGSLOT: ${PGSLOT}"
	dodir /usr/share/postgresql-${PGSLOT}/contrib/
	insinto /usr/share/postgresql-${PGSLOT}/contrib/
	doins repmgr.sql uninstall_repmgr.sql
	dobin repmgr repmgrd
	insinto /etc
	newins repmgr.conf repmgr.conf.sample
	fowners postgres:postgres /etc/repmgr.conf.sample
	newconfd ${FILESDIR}/repmgrd.confd repmgrd
	newinitd ${FILESDIR}/repmgrd.initd repmgrd
	dodoc  CREDITS COPYRIGHT README.rst LICENSE TODO
	ewarn "Edit /etc/repmgr.conf which required for repmgrd daemon."
}
