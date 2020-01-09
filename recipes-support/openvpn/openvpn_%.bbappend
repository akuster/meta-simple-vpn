FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

inherit openvpn useradd

do_install_append_simple-vpn () {
	install -m 0600 ${OPENVPN_SERVER_CONF} ${D}/${sysconfdir}/openvpn/.
	install -m 0555 ${B}/ifup.sh ${D}/${sysconfdir}/openvpn/.
	install -m 0555 ${B}/ifdown.sh ${D}/${sysconfdir}/openvpn/.
}

USERADD_PACKAGES = "${PN}"
GROUPADD_PARAM_${PN} = "--system ${VPN_USER}"
USERADD_PARAM_${PN} = "--system -g ${VPN_GROUP} --home-dir  \
    ${localstatedir}/spool/${BPN} \
        --no-create-home  --shell /bin/false ${BPN}"

SYSTEMD_AUTO_ENABLE_simple-vpn = "disable"
SYSTEMD_SERVICE_${PN}_simple-vpn = "openvpn@server.service"
