do_install_append_simple-vpn () {
	sed -i -e 's:#Port 22:Port 2222:' ${D}${sysconfdir}/ssh/sshd_config
	sed -i -e 's:#MaxAuthTries 6:MaxAuthTries 3:' ${D}${sysconfdir}/ssh/sshd_config
}
