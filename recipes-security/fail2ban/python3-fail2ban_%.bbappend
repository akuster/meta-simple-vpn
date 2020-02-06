FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append_simple-vpn = "\ 
	file://jail.local \
	file://ufw-ssh.conf \
"

do_install_append_simple-vpn () {
	install -d ${D}/${sysconfdir}/fail2ban
	install -d ${D}/${sysconfdir}/fail2ban/action.d
	install -m 0755 ${WORKDIR}/ufw-ssh.conf ${D}${sysconfdir}/fail2ban/action.d
	install -m 0744 ${WORKDIR}/jail.local ${D}${sysconfdir}/fail2ban/jail.conf
}
