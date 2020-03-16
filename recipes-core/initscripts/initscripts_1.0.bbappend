FILESEXTRAPATHS_append_simple-vpn := ":${THISDIR}/${BPN}"

SRC_URI_simple-vpn += "file://mountall.sh "


do_install_append_simple-vpn() {
    install -m 0755 ${WORKDIR}/mountall.sh ${D}${sysconfdir}/init.d
}
