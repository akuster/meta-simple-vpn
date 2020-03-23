FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append_simple-vpn = " file://mountall.sh"

do_install_append_simple-vpn() {
    install -d ${D}${sysconfdir}/init.d
    install -m 0755 ${WORKDIR}/mountall.sh ${D}${sysconfdir}/init.d
}
