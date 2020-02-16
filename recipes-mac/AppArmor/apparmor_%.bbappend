
do_install_append_simple-vpn () {
	rm -f ${D}${sysconfdir}/apparmor.d/sbin.syslogd
}
