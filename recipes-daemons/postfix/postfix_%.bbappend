POSTFIX_MAIN_CONF ?= "${B}/postfix_main_alt"

inherit postfix

do_install_append_simple-vpn () {

    install -d ${D}${sysconfdir}/postfix

    sed -i -e 's@^mydomain.*@mydomain=${POSTFIX_DOMAINNAME}@'  ${D}${sysconfdir}/postfix/main.cf
    sed -i -e 's@^#myhostname.*@myhostname=${POSTFIX_MYHOSTNAME}@'  ${D}${sysconfdir}/postfix/main.cf
    sed -i -e 's@^virtual_mailbox_maps.*@virtual_mailbox_maps = hash:/etc/aliases@'  ${D}${sysconfdir}/postfix/main.cf
    sed -i -e 's@^virtual_alias_maps.*@virtual_alias_maps = hash:/etc/aliases@'  ${D}${sysconfdir}/postfix/main.cf
    sed -i -e 's@^virtual_mailbox_domains.*@virtual_mailbox_domains = ${POSTFIX_DOMAINNAME}@'  ${D}${sysconfdir}/postfix/main.cf
    cat ${POSTFIX_MAIN_CONF} >> ${D}${sysconfdir}/postfix/main.cf

    echo "${POSTFIX_ACCOUNT}:${POSTFIX_EMAIL}" > ${D}${sysconfdir}/aliases
    echo "${POSTFIX_RELAYHOST} ${POSTFIX_EMAIL}:${POSTFIX_EMAIL_PASSWD}" > ${D}${sysconfdir}/postfix/sasl_passwd
    chmod 400 ${D}${sysconfdir}/postfix/sasl_passwd
}

pkg_postinst_ontarget_${PN} () {
    postmap /etc/postfix/sasl_passwd
}
