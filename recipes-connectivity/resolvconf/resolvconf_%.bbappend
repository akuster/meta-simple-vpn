inherit resolvconf

do_install_append_simple-vpn () {
    install ${MY_BASE} ${D}/${sysconfdir}/resolvconf/resolv.conf.d/base
}
