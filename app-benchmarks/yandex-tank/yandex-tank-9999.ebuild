# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Load and performance benchmark tool"
HOMEPAGE="http://clubs.ya.ru/yandex-tank/"
GIT_SHA1="21a4a29"
SRC_URI="https://github.com/yandex-load/yandex-tank/tarball/${GIT_SHA1} -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

PYTHON_DEPEND="2:2.7"

DEPEND=">=dev-lang/python-2.7
	dev-python/psutil
	dev-python/ipaddr
	dev-python/lxml
	app-misc/phantom"

RDEPEND="${DEPEND}"
S="${WORKDIR}/yandex-load-yandex-tank-${GIT_SHA1}"

src_prepare() {
	cp ${FILESDIR}/yandex-tank-setup.py ${S}/setup.py
}

python_install() {
	distutils-r1_python_install

	mkdir -p ${D}/usr/lib/python2.7/site-packages/Tank/Plugins
	cp ${S}/Tank/Plugins/*.{tpl,xml,txt,html} ${D}/usr/lib/python2.7/site-packages/Tank/Plugins/

	newbin ${S}/tank.py yandex-tank
	dodir /etc/yandex-tank
	insinto /etc/yandex-tank
		doins ${FILESDIR}/load.ini
		doins ${FILESDIR}/00-base.ini
		doins ${FILESDIR}/sysctl.conf
}

pkg_postinst() {
	elog
	elog "After installation and before firing of targets,"
	elog "it's recommended to change sysctl setting."
	elog "See example in /etc/yandex-tank/sysctl.conf"
	elog "Also useful to increase open files limit with 'uname -n 30000'"
	elog
}
