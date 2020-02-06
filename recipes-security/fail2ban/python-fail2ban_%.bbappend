FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append_simple-vpn = "\ 
	file://jail.local \
"

do_install_append_simple-vpn () {
	install -d ${D}/${sysconfdir}/fail2ban
	install -m 0744 ${WORKDIR}/jail.local ${D}${sysconfdir}/fail2ban
	rm -f ${D}${sysconfdir}/fail2ban/jail.conf
}
