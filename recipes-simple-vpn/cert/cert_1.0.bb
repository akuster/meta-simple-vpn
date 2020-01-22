SUMMARY = "Create CA cert and keys"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"
LICENSE = "GPLv2"
SECTION = "Security/Cryptography"

DEPENDS += "cert-native"

inherit easy-rsa-cert allarch

PASSPHRASE ?= "SimpleVpn"
COMMON_NAME ?= "server"
SERVER_NAME ?= "server"
CLIENT_NAME ?= ""
CERT_DIR ?= "openvpn/ssl"

STAGING_EASYRSA_BUILDDIR ?= "${TMPDIR}/work-shared/easyrsa"

do_configure[noexec] = "1"
do_compile[noexec] = "1"

do_install () {
	install -d ${D}/${sysconfdir}/${CERT_DIR}

	install -m 600 ${STAGING_EASYRSA_BUILDDIR}/${CERT_DIR}/${SERVER_NAME}.crt ${D}/${sysconfdir}/${CERT_DIR}
	install -m 600 ${STAGING_EASYRSA_BUILDDIR}/${CERT_DIR}/${SERVER_NAME}.key ${D}/${sysconfdir}/${CERT_DIR}

	install -m 600 ${STAGING_EASYRSA_BUILDDIR}/${CERT_DIR}/ca.* ${D}/${sysconfdir}/${CERT_DIR}
	install -m 600 ${STAGING_EASYRSA_BUILDDIR}/${CERT_DIR}/dh.pem ${D}/${sysconfdir}/${CERT_DIR}
	install -m 600 ${STAGING_EASYRSA_BUILDDIR}/${CERT_DIR}/ta.key ${D}/${sysconfdir}/${CERT_DIR}

    if [ ! -z "${CLIENT_NAME}" ]; then
	    install -d ${D}/${sysconfdir}/${CERT_DIR}/client
	    install -m 600 ${STAGING_EASYRSA_BUILDDIR}/${CERT_DIR}/client/${CLIENT_NAME}.crt ${D}/${sysconfdir}/${CERT_DIR}/client
	    install -m 600 ${STAGING_EASYRSA_BUILDDIR}/${CERT_DIR}/client/${CLIENT_NAME}.key ${D}/${sysconfdir}/${CERT_DIR}/client
    fi
}

PACKAGES = "${PN}-server ${PN}-client ${PN}-ca-crt ${PN}-ca-key ${PN}-ta ${PN}-pem"

FILES_${PN}-ca-crt = "${sysconfdir}/${CERT_DIR}/ca.crt"
FILES_${PN}-ca-key = "${sysconfdir}/${CERT_DIR}/ca.key"
FILES_${PN}-ta = "${sysconfdir}/${CERT_DIR}/ta.key"
FILES_${PN}-pem = "${sysconfdir}/${CERT_DIR}/dh.pem"
FILES_${PN}-client = "${sysconfdir}/${CERT_DIR}/client/*"
FILES_${PN}-server = "${sysconfdir}/${CERT_DIR}/${SERVER_NAME}.*"

RDEPENDS_${PN}-server += "${PN}-ca-crt  ${PN}-ta ${PN}-pem openvpn"
RDEPENDS_${PN}-client += "${PN}-ca-crt ${PN}-ta "
