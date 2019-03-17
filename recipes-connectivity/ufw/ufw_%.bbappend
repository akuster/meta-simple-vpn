FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI2 += " \
	file://ufw.service \
	file://sysctl.conf \
	file://before.rules \
"
#inherit update-rc.d

#INITSCRIPT_PACKAGES = "${PN}"
#INITSCRIPT_NAME = "${BPN}-init"

do_install2_append () {
#	install -d ${D}/${systemd_unitdir}/system
#	install -d ${D}/${sysconfdir}/ufw
#	install -d ${D}${sysconfdir}/init.d

#	install -m 644 ${WORKDIR}/ufw.service ${D}/${systemd_unitdir}/system
#	install -m 644 ${WORKDIR}/sysctl.conf ${D}/${sysconfdir}/ufw/.
#	install -m 644 ${WORKDIR}/before.rules ${D}/${sysconfdir}/ufw/.
#	install -m 755 ${S}/src/ufw-init ${D}${sysconfdir}/init.d/${BPN}-init
#	sed -i -e 's:\#CONFIG_PREFIX\#:${sysconfdir}:g' ${D}${sysconfdir}/init.d/${BPN}-init
#	sed -i -e 's:\#STATE_PREFIX\#:${nonarch_base_libdir}/ufw:g' ${D}${sysconfdir}/init.d/${BPN}-init
#	sed -i -e 's/ENABLED=no/ENABLED=yes/g' ${D}${sysconfdir}/ufw/ufw.conf
}

#SYSTEMD_AUTO_ENABLE = "disable"
#SYSTEMD_SERVICE_${PN} = "ufw.service"
#FILES_${PN} += "${systemd_unitdir}/system/ufw.service"
