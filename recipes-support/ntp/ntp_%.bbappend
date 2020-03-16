inherit ntp

do_install_append_simple-vpn () {
    rm -f ${D}${sysconfdir}/ntp.conf
    install -m 744 ${NTP_CONF} ${D}${sysconfdir}/ntp.conf
    install -d  ${D}${sysconfdir}/cron.hourly

    echo "" >> ${D}${sysconfdir}/ntp.conf
    echo "server 127.0.0.1" >> ${D}${sysconfdir}/ntp.conf
    echo "listen on *" >> ${D}${sysconfdir}/ntp.conf
    echo "listen on 127.0.0.1" >> ${D}${sysconfdir}/ntp.conf
    echo "listen on ::1" >> ${D}${sysconfdir}/ntp.conf
    echo "" >> ${D}${sysconfdir}/ntp.conf
    echo "restrict -4 default notrap nomodify nopeer noquery" >> ${D}${sysconfdir}/ntp.conf
    echo "restrict -6 default notrap nomodify nopeer noquery" >> ${D}${sysconfdir}/ntp.conf
    echo "restrict 127.0.0.1    # allow local host" >> ${D}${sysconfdir}/ntp.conf
    echo "restrict ::1          # allow local host" >> ${D}${sysconfdir}/ntp.conf

    echo "/usr/bin/ntpdate-sync silent" >  ${D}${sysconfdir}/cron.hourly/ntpdate
}

PACKAGES_append = " ${PN}-cronhourly"

FILES_${PN}-cronhourly = "${sysconfdir}/cron.hourly"
