inherit interfaces

do_install_append () {
	install -m 0644  ${MY_INTERFACE} ${D}${sysconfdir}/network/interfaces
}
