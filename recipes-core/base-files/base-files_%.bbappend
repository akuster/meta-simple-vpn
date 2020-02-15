FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

BASEFILESISSUEINSTALL = "do_install_simple_vpn"

SRC_URI_simple-vpn = "\
    file://issue \
    file://issue.net \
    "
do_install_simple_vpn () {
    install -m 644 ${WORKDIR}/issue*  ${D}${sysconfdir}
    echo 'export PATH="$PATH:/usr/local/sbin:/usr/sbin:/sbin"' >> ${D}/${sysconfdir}/profile
}
