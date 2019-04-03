FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

OPENVPN_SERVER_CONF_simple-vpn="server.conf"

SRC_URI_append_simple-vpn = "\ 
	file://${OPENVPN_SERVER_CONF} \
	file://ifup.sh \
	file://ifdown.sh \
"

do_install_append_simple-vpn () {
	install -m 0600 ${WORKDIR}/${OPENVPN_SERVER_CONF} ${D}/${sysconfdir}/openvpn/.
	install -m 0555 ${WORKDIR}/if*.sh ${D}/${sysconfdir}/openvpn/.
}

SYSTEMD_AUTO_ENABLE_simple-vpn = "disable"
SYSTEMD_SERVICE_${PN}_simple-vpn = "openvpn@server.service"
