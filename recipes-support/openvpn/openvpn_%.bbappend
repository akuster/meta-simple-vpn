FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

OPENVPN_SERVER_CONF="server.conf"

SRC_URI += " \
	file://${OPENVPN_SERVER_CONF} \
	file://ifup.sh \
	file://ifdown.sh \
"

do_install_append () {
	install -m 0600 ${WORKDIR}/${OPENVPN_SERVER_CONF} ${D}/${sysconfdir}/openvpn/.
	install -m 0555 ${WORKDIR}/if*.sh ${D}/${sysconfdir}/openvpn/.
}

SYSTEMD_AUTO_ENABLE = "disable"
SYSTEMD_SERVICE_${PN} = "openvpn@server.service"
