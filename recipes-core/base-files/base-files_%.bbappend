FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

BASEFILESISSUEINSTALL_simple-vpn = "do_install_basefilesissue_simple_vpn"

SRC_URI_append_simple-vpn = "\
    file://issue \
    file://issue.net \
    "

do_install_append_simple-vpn () {
	sed -i 's/umask.*/umask 027/g' ${D}/${sysconfdir}/profile
}

do_install_basefilesissue_simple_vpn () {
    install -m 644 ${WORKDIR}/issue*  ${D}${sysconfdir}
    echo 'export PATH="$PATH:/usr/local/sbin:/usr/sbin:/sbin"' >> ${D}/${sysconfdir}/profile
}
