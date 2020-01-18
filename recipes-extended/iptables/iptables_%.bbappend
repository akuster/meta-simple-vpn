FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

IPTABLES_IN ?= "eth0"
IPTABLES_OUT ?= "eth1"

SRC_URI_append_simple-vpn = " file://iptables.rules"

do_install_append_simple-vpn () {
    install -d ${D}${sysconfdir}/${BPN}
    install -m 0644 ${WORKDIR}/iptables.rules ${D}${sysconfdir}/${BPN}/.

    sed -i -e 's/#SRC#/${IPTABLES_IN}/g' ${D}${sysconfdir}/${BPN}/iptables.rules
    sed -i -e 's/#DEST#/${IPTABLES_OUT}/g' ${D}${sysconfdir}/${BPN}/iptables.rules
}
