inherit ntp

do_install_append_simple-vpn () {
    rm -f ${D}${sysconfdir}/ntp.conf
    install -m 744 ${NTP_CONF} ${D}${sysconfdir}/ntp.conf

    echo "restrict -4 default notrap nomodify nopeer noquery" >> ${D}${sysconfdir}/ntp.conf
    echo "restrict -6 default notrap nomodify nopeer noquery" >> ${D}${sysconfdir}/ntp.conf
    echo "restrict 127.0.0.1    # allow local host" >> ${D}${sysconfdir}/ntp.conf
    echo "restrict ::1          # allow local host" >> ${D}${sysconfdir}/ntp.conf
}
