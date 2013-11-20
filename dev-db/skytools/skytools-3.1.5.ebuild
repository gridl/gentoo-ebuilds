# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.* *-jython"

inherit autotools python

DESCRIPTION="Database management tools from Skype: WAL shipping, queueing, replication."
HOMEPAGE="http://pgfoundry.org/projects/skytools/"
SRC_URI="http://pgfoundry.org/frs/download.php/3515/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=dev-db/postgresql-server-8.2
		dev-python/psycopg:2
		dev-libs/libevent
		net-misc/rsync"

RDEPEND="${DEPEND}"

src_install() {
		default

		dodoc README NEWS COPYRIGHT
		dodir /etc/skytools /var/log/skytools /var/run/skytools
		newinitd "${FILESDIR}"/pgqd.initd-${PV} pgqd
		newconfd "${FILESDIR}"/pgqd.confd-${PV} pgqd
		insinto /etc/logrotate.d
		newins "${FILESDIR}"/pgqd.logrotate-${PV} pgqd
		insinto /etc/skytools
		newins "${FILESDIR}"/pgqd.ini.sample-${PV} pgqd.ini.sample
}
