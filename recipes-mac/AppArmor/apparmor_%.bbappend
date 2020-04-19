
do_install_append_simple-vpn () {
	rm -f ${D}${sysconfdir}/apparmor.d/sbin.syslogd
	rm -f ${D}${sysconfdir}/apparmor.d/sbin.klogd
	rm -f ${D}${sysconfdir}/apparmor.d/local/sbin.klogd
}
