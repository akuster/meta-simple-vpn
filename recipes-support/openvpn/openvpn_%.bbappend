FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

DEPENDS_class-native = "lzo-native openssl-native "

inherit openvpn useradd

VPN_USER ?= "nobody"
VPN_GROUP ?= "nobody"

do_install_append_simple-vpn () {
	install -d ${D}${sysconfdir}/openvpn/client

	install -m 0600 ${OPENVPN_SERVER_CONF} ${D}/${sysconfdir}/openvpn/.
	install -m 0600 ${OPENVPN_CLIENT_CONF} ${D}${sysconfdir}/openvpn/client/.

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
EXTRA_OECONF_remove_simple-vpn = "--enable-iproute2"
BBCLASSEXTEND = "native"
