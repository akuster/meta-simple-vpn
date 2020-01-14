SUMMARY = "easy-rsa is a CLI utility to build and manage a PKI CA. In laymen's terms, this means to create a root certificate authority, and request and sign certificates, including sub-CAs and certificate revokation lists (CRL)."
HOMEPAGE = "http://openvpn.net"
LIC_FILES_CHKSUM = "file://Licensing/gpl-2.0.txt;md5=75859989545e37968a99b631ef42722e"
LICENSE = "GPLv2"
SECTION = "Security/Cryptography"

SRCREV = "4152244bae2101018410df952e0bc00049947f8a"
SRC_URI = "git://github.com/OpenVPN/easy-rsa.git;branch='v${PV}'"

S = "${WORKDIR}/git"

inherit allarch

do_configure[noexec] = "1"
do_compile[noexec] = "1"

do_install () {
	install -d ${D}/${bindir}
	install -d ${D}/${mandir}/${BPN}
	install -d ${D}/${datadir}/${BPN}
	install -d ${D}/${sysconfdir}/easyrsa3/x509-types

	install -m 750 ${B}/easyrsa3/easyrsa ${D}/${bindir}
    install ${B}/doc/* ${D}/${mandir}/${BPN}
    install ${B}/Licensing/* ${D}/${datadir}/${BPN}
	install -m 775 ${B}/easyrsa3/*.cnf ${D}/${sysconfdir}/easyrsa3
	install -m 775 ${B}/easyrsa3/x509-types/* ${D}/${sysconfdir}/easyrsa3/x509-types
}

do_install_append-class-native () {
	install -d ${D}/${bindir}
	install -d ${D}/${sysconfdir}/easyrsa3/x509-types

	install -m 755 ${B}/easyrsa3/easyrsa ${D}/${bindir}
	install -m 775 ${B}/easyrsa3/*.cnf ${D}/${sysconfdir}/easyrsa3
	install -m 775 ${B}/easyrsa3/x509-types/* ${D}/${sysconfdir}/easyrsa3/x509-types
}

FILES_${PN} += "${sbindir}/easyrsa"

RDEPENDS_${PN} = "openssl"
BBCLASSEXTEND = "native"
