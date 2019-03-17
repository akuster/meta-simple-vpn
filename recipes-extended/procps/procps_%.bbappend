FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += "file://mysysctl.conf"

do_install_append () {
	install -d ${D}${sysconfdir}
	install -m 0644 ${WORKDIR}/mysysctl.conf ${D}${sysconfdir}/sysctl.conf
}
