do_install_append_simple-vpn () {
	# to hardend
	sed -i -e 's:UMASK.*:UMASK 027:' ${D}${sysconfdir}/login.defs
	sed -i -e 's:PASS_MAX_DAYS.*:PASS_MAX_DAYS 365:' ${D}${sysconfdir}/login.defs
	sed -i -e 's:PASS_MIN_DAYS.*:PASS_MIN_DAYS 0:' ${D}${sysconfdir}/login.defs
	sed -i -e 's:#PASS_MIN_LEN.*:PASS_MIN_LEN 11:' ${D}${sysconfdir}/login.defs
	sed -i -e 's:PASS_WARN_AGE.*:PASS_WARN_AGE 14:' ${D}${sysconfdir}/login.defs
}