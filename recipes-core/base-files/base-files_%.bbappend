FILESEXTRAPATHS_prepend_simple-vpn := "${THISDIR}/files:"

BASEFILESISSUEINSTALL_simple-vpn = "do_install_basefilesissue_simple_vpn"

SRC_URI_append_simple-vpn = "\
    file://issue \
    file://issue.net \
    "

do_install_append_simple-vpn () {
    sed -i 's/umask.*/umask 027/g' ${D}/${sysconfdir}/profile
    echo 'export PATH="$PATH:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin"' >> ${D}/${sysconfdir}/profile
}

do_install_basefilesissue_simple_vpn () {
    install -m 644 ${WORKDIR}/issue*  ${D}${sysconfdir}
}
