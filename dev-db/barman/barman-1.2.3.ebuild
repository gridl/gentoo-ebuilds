# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="Administration tool for disaster recovery of PostgreSQL servers"
HOMEPAGE="http://www.pgbarman.org"
SRC_URI="http://downloads.sourceforge.net/project/pgbarman/${PV}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/argh[${PYTHON_USEDEP}]
		>=dev-python/psycopg-2[${PYTHON_USEDEP}]
		dev-python/python-dateutil[${PYTHON_USEDEP}]
		net-misc/rsync
		dev-db/postgresql-base"
DEPEND=""

pkg_setup() {
		enewgroup barman
		enewuser barman -1 /bin/bash /var/lib/barman barman
}

python_install_all() {
		distutils-r1_python_install_all
		keepdir /etc/barman.d
		dodir /etc/barman.d
		dodir /var/log/barman
		insinto /etc
		doins ${FILESDIR}/barman.conf.sample
		fowners barman:barman /var/log/barman
}
