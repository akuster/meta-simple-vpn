FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append_simple-vpn = "file://openvpn \
                             file://fail2ban "

do_install_append_simple-vpn () {
    install -d ${D}${sysconfdir}/logrotate.d
    install -p -m 644 ${WORKDIR}/openvpn ${D}${sysconfdir}/logrotate.d/.
    install -p -m 644 ${WORKDIR}/fail2ban ${D}${sysconfdir}/logrotate.d/.
    sed -i -e 's:#compress:compress:' ${D}${sysconfdir}/logrotate.conf
}
