FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += " \
	file://jail.conf \
	file://ufw-ssh.conf \
"

do_install_append () {
	install -d ${D}/${sysconfdir}/fail2ban
	install -d ${D}/${sysconfdir}/fail2ban/action.d
	install -m 0755 ${WORKDIR}/jail.conf ${D}${sysconfdir}/fail2ban
	install -m 0755 ${WORKDIR}/ufw-ssh.conf ${D}${sysconfdir}/fail2ban/action.d
}
