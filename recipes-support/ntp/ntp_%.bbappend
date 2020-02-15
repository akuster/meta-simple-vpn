do_install_append_simple-vpn () {
    # to hardend
    sed -i -e 's:server 127.127.1.0::' ${D}${sysconfdir}/ntp.conf
    sed -i -e 's:fudge 127.127.1.0 stratum 14::' ${D}${sysconfdir}/ntp.conf
    echo 'server 0.north-america.pool.ntp.org' >> ${D}${sysconfdir}/ntp.conf
    echo 'server 1.north-america.pool.ntp.org' >> ${D}${sysconfdir}/ntp.conf
    echo 'server 2.north-america.pool.ntp.org' >> ${D}${sysconfdir}/ntp.conf
}
