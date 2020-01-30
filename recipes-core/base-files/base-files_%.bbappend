
do_install_append_simple-vpn () {
    echo 'export PATH="$PATH:/usr/local/sbin:/usr/sbin:/sbin"' >> ${D}/${sysconfdir}/profile
}
