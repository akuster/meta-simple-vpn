FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

inherit openvpn

do_install_append_simple-vpn () {
	install -m 0600 ${OPENVPN_SERVER_CONF} ${D}/${sysconfdir}/openvpn/.
	install -m 0555 ${B}/ifup.sh ${D}/${sysconfdir}/openvpn/.
	install -m 0555 ${B}/ifdown.sh ${D}/${sysconfdir}/openvpn/.
}

SYSTEMD_AUTO_ENABLE_simple-vpn = "disable"
SYSTEMD_SERVICE_${PN}_simple-vpn = "openvpn@server.service"
