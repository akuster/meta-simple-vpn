FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append_simple-vpn = " file://mysysctl.conf"

do_install_append_simple-vpn () {
	install -d ${D}${sysconfdir}
	install -m 0644 ${WORKDIR}/mysysctl.conf ${D}${sysconfdir}/sysctl.conf
}
