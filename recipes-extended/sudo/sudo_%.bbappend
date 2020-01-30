
PACKAGECONFIG_append_simple-vpn = " pam-wheel"
do_install_append_simple-vpn () {
    if [ "${@bb.utils.contains('DISABLE_ROOT', 'True', '1', '0', d)}" ]; then
        sed -i -e 's:root ALL=(ALL) ALL:#root ALL=(ALL) ALL:' ${D}${sysconfdir}/sudoers
    fi
}