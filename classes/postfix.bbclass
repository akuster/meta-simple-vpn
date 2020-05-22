#
# Postfix config class
#
POSTFIX_ACCOUNT ?= "postfix"
POSTFIX_MYHOSTNAME ?= "server.example.com"
POSTFIX_DOMAINNAME ?= "example.com"
POSTFIX_SMPTD_BANNER ?= "$myhostname ESMTP $mail_name"
POSTFIX_VITRUAL_MAILBOX_DOMAINS ?= "example.com"
POSTFIX_VITRUAL_MAILBOX_MAPS ?= "hash:/etc/postfix/vmailbox"
POSTFIX_VIRTUAL_ALIAS_MAPS ?= "hash:/etc/postfix/virtual"
POSTFIX_RELAYHOST ?= "[smtp.gmail.com]:587"
POSTFIX_SMTP_SASL_AUTH_ENABLE ?= "yes"
POSTFIX_SMTP_SASL_PASSWORD_MAPS ?= "hash:/etc/postfix/sasl_passwd"
POSTFIX_SMTP_SASL_SECURITY_OPTIONS ?= "noanonymous"
POSTFIX_SMTP_TLS_CAFILE ?= "/etc/postfix/cacert.pem"
POSTFIX_SMTP_USE_TLS ?= "yes"
POSTFIX_EMAIL ?= "me@example.com"
POSTFIX_EMAIL_PASSWD ?= "12345"

POSTFIX_MAIN_CONF ?= "${B}/postfix_main_alt"

python create_postfix_main_conf() {

    cfile = d.getVar('POSTFIX_MAIN_CONF')
    if not cfile:
        bb.fatal('Unable to read NTP_CONF')

    localdata = bb.data.createCopy(d)

    smtpd_banner = localdata.getVar('POSTFIX_SMPTD_BANNER')

    relayhost = localdata.getVar('POSTFIX_RELAYHOST')
    smtp_sasl_auth_enable = localdata.getVar('POSTFIX_SMTP_SASL_AUTH_ENABLE')
    smtp_sasl_password_maps = localdata.getVar('POSTFIX_SMTP_SASL_PASSWORD_MAPS')
    smtp_sasl_security_options = localdata.getVar('POSTFIX_SMTP_SASL_SECURITY_OPTIONS')
    smtp_tls_CAfile = localdata.getVar('POSTFIX_SMTP_TLS_CAFILE')
    smtp_use_tls = localdata.getVar('POSTFIX_SMTP_USE_TLS')

    try:
        with open(cfile, 'w') as cfgfile:
#            cfgfile.write('smtpd_banner = %s\n' % smtpd_banner)
            cfgfile.write('relayhost = %s\n' % relayhost)
            cfgfile.write('smtp_sasl_auth_enable =  %s\n' % smtp_sasl_auth_enable )
            cfgfile.write('smtp_sasl_password_maps = %s\n' % smtp_sasl_password_maps)
            cfgfile.write('smtp_sasl_security_options = %s\n' % smtp_sasl_security_options)
            cfgfile.write('smtp_tls_CAfile = %s\n' % smtp_tls_CAfile)
            cfgfile.write('smtp_use_tls = %s\n' % smtp_use_tls)

    except OSError:
        bb.fatal('Unable to open %s' % cfile)
}

do_compile[prefuncs] += "create_postfix_main_conf"
