do_install_append_simple-vpn () {
	sed -i -e 's:#Port 22:Port 2222:' ${D}${sysconfdir}/ssh/sshd_config
	sed -i -e 's:#MaxAuthTries 6:MaxAuthTries 3:' ${D}${sysconfdir}/ssh/sshd_config
	sed -i -e 's:PermitEmptyPasswords yes:PermitEmptyPasswords no:' ${D}${sysconfdir}/ssh/sshd_config

    if [ "${@bb.utils.contains('DISABLE_ROOT', 'True', 'yes', 'no', d)}" = "yes" ]; then
        sed -i -e 's:#PermitRootLogin.*:PermitRootLogin prohibit-password:' ${D}${sysconfdir}/ssh/sshd_config
    else
        sed -i -e 's:#PermitRootLogin.*:PermitRootLogin yes:' ${D}${sysconfdir}/ssh/sshd_config
    fi

    if [ "${@bb.utils.filter('DISTRO_FEATURES', 'pam', d)}" ]; then
        sed -i -e 's:#PasswordAuthentication yes:PasswordAuthentication yes:' ${D}${sysconfdir}/ssh/sshd_config
        sed -i -e 's:ChallengeResponseAuthentication no:ChallengeResponseAuthentication yes:' ${D}${sysconfdir}/ssh/sshd_config
    	if [ "${@bb.utils.filter('DISTRO_FEATURES', '2fa', d)}" ]; then
            echo "#Move this up to the top if you wat it got go first" >> ${D}${sysconfdir}/pam.d/sshd
            echo "#auth required pam_google_authenticator.so" >> ${D}${sysconfdir}/pam.d/sshd
        fi
    fi
}
