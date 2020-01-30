FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append_simple-vpn = "\ 
	file://jail.conf \
"

do_install_append_simple-vpn () {
	install -d ${D}/${sysconfdir}/fail2ban
	install -m 0755 ${WORKDIR}/jail.conf ${D}${sysconfdir}/fail2ban
}
