FILESEXTRAPATHS_prepend := "${THISDIR}/systemd:"

SRC_URI += " \
    file://rndis.network \
    file://sub1.network \
"

PACKAGECONFIG_append = " networkd"

do_install_append() {
    # The network files need to be in /usr/lib/systemd, not ${systemd_unitdir}...
    install -d ${D}${prefix}/lib/systemd/network/
    install -d $[D}/$[sysconfdir}/systemd/network/
    install -m 0644 ${WORKDIR}/rndis.network ${D}${prefix}/lib/systemd/network/
}
#    install -m 0644 ${WORKDIR}/sub1.network ${D}${sysconfdir}/systemd/network/

FILES_${PN} += " \
    ${nonarch_base_libdir}/systemd/network \
"
