#
# 
#

SUMMARY = "Simple VPN groups"

inherit packagegroup

PROVIDES = "${PACKAGES}"
PACKAGES = "${PN}  \
	packagegroup-openvpn \
	packagegroup-iptables \
	packagegroup-ufw \
"

RDEPENDS_${PN} = "\
	init-ifupdown \
	ipsec-tools \
	procps \
	resolvconf \
	lzo \
	openssl \
        openssl-bin \
	libssl \
	libcrypto \
	openssl-conf \
	openssl-engines \
	tunctl \
	bridge-utils \
	openssh-sshd \
	openssh-keygen \
        openssh-scp \
	packagegroup-openvpn \
	packagegroup-ufw \
	kernel-modules \
	iproute2 \
	iptables \
	sysklogd \
	python-fail2ban \
	lsb \
        ntpdate \
        ntp-tickadj \
        ntp \
        sntp \
        ntp-utils \
        tzdata \
	tzdata-americas \
	tzdata-misc \
	tzdata-posix \
	tzdata-right \
"

# Needed for openvpn support
RDEPENDS_packagegroup-openvpn = "\
	easy-rsa \
	openvpn \
	openvpn-sample \
	kernel-module-tun \
"

# Needed for strongswan support
RDEPENDS_packagegroup-strongswan = "\
	strongswan \
	strongswan-plugin-xauth-generic \
	strongswan-plugin-des \
	strongswan-plugin-hmac \
	strongswan-plugin-pubkey \
	strongswan-plugin-pkcs1 \
	strongswan-plugin-pkcs12 \
	strongswan-plugin-resolve \
	strongswan-plugin-aes \
"
# needed for iptables support
RDEPENDS_packagegroup-iptables = "\
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

# Needed for ufw support
RDEPENDS_packagegroup-ufw = "\
	ufw \
"
