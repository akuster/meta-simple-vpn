#
# 
#

SUMMARY = "Simple VPN groups"

inherit packagegroup

PROVIDES = "${PACKAGES}"
PACKAGES = "${PN}  \
    packagegroup-openvpn \
    packagegroup-iptables \
"

RDEPENDS_${PN} = "\
    init-ifupdown \
    procps \
    resolvconf \
    lzo \
    openssl \
    libssl \
    libcrypto \
    openssl-conf \
    openssl-engines \
    tunctl \
    bridge-utils \
    openssh-sshd \
    openssh-keygen \
    packagegroup-openvpn \
    kernel-modules \
    iproute2 \
    iptables \
    ${VIRTUAL-RUNTIME_base-utils-syslog} \
    python3-fail2ban \
    ntpdate \
    ntp-tickadj \
    ntp \
    sntp \
    ntpq \
    ntp-utils \
    ntp-cronhourly \
    tzdata \
    tzdata-americas \
    tzdata-misc \
    tzdata-posix \
    tzdata-right \
    logrotate \
    cronie \
    sudo \
    util-linux \
    suricata \
    python3-suricata-update \
    chkrootkit \
    postfix \
    postfix-cfg \
    arpwatch \
    ${@bb.utils.contains("DISTRO_FEATURES", "apparmor", "apparmor", "",d)} \
    ${@bb.utils.contains("DISTRO_FEATURES", "pam", "pam-plugin-wheel", "",d)} \
    ${@bb.utils.contains("DISTRO_FEATURES", "pam 2fa", "google-authenticator-libpam pam-google-authenticator", "",d)} \
"

# Needed for openvpn support
RDEPENDS_packagegroup-openvpn = "\
    cert-server \
    openvpn \
    kernel-module-tun \
"

# needed for iptables support
RDEPENDS_packagegroup-iptables = "\
    iptables-modules \
    kernel-module-x-tables \
    kernel-module-ip-tables \
    kernel-module-iptable-filter \
    kernel-module-iptable-nat \
    kernel-module-nf-defrag-ipv4 \
    kernel-module-nf-conntrack \
    kernel-module-nf-conntrack-ipv4 \
    kernel-module-nf-nat \
    kernel-module-ipt-masquerade \
"
