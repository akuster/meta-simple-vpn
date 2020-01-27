SUMMARY = "Create CA cert and keys"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"
LICENSE = "GPLv2"
SECTION = "Security/Cryptography"

DEPENDS += "easy-rsa-native openvpn-native"

inherit native easy-rsa-cert

PASSPHRASE ?= "SimpleVpn"
COMMON_NAME ?= "server"
SERVER_NAME ?= "server"
CLIENT_NAME ?= "client"
CERT_DIR ?= "openvpn/ssl"

CERT_AUTO_GEN ?= "1"

CERT_SRC_DIR ?= ""

STAGING_EASYRSA_BUILDDIR ?= "${TMPDIR}/work-shared/easyrsa"

do_configure[noexec] = "1"

do_compile() {
    if [ "${CERT_AUTO_GEN}" -eq "1" ]; then

        chmod +x ${EASYRSA_VARS_FILE}
        ( echo "yes"; ) |  easyrsa --vars="./${EASYRSA_VARS_FILE}" init-pki

        cp ${STAGING_ETCDIR_NATIVE}/easyrsa3/openssl-easyrsa.cnf pki/.

        ( echo  "${COMMON_NAME}"; ) | easyrsa --vars="./${EASYRSA_VARS_FILE}" build-ca nopass

        # Keypair and certificate request
        ( echo "${COMMON_NAME}"; ) | easyrsa --vars="./${EASYRSA_VARS_FILE}" gen-req ${SERVER_NAME} nopass
        (echo "yes"; ) | easyrsa --vars="./${EASYRSA_VARS_FILE}" sign-req server ${SERVER_NAME} 
    
        (echo "${CLIENT_NAME}" ) | easyrsa --vars="./${EASYRSA_VARS_FILE}" gen-req ${CLIENT_NAME} nopass

        (echo "yes";) | easyrsa --vars="./${EASYRSA_VARS_FILE}" sign-req client ${CLIENT_NAME}

        #${bindir_native}/easyrsa import-req /path/to/received.req ${UNIQUE_SHORT_FILE_NAMES}

        easyrsa --vars="./${EASYRSA_VARS_FILE}" gen-dh

        openvpn --genkey --secret pki/ta.key
    else
        mkdir -p ${B}/pki
        cp ${CERT_SRC_DIR}/ca.crt  ${B}/pki/.
        cp ${CERT_SRC_DIR}/ta.key  ${B}/pki/.
        cp ${CERT_SRC_DIR}/dh.pem  ${B}/pki/.

        mkdir -p ${B}/pki/issued
        mkdir -p ${B}/pki/private
        cp ${CERT_SRC_DIR}/${SERVER_NAME}.key  ${B}/pki/private/${SERVER_NAME}.key
        cp ${CERT_SRC_DIR}/${SERVER_NAME}.crt  ${B}/pki/issued/${SERVER_NAME}.crt
    fi
}

do_install () {
    install -d ${STAGING_EASYRSA_BUILDDIR}/${CERT_DIR}

    install -m 600 ${B}/pki/ca.crt ${STAGING_EASYRSA_BUILDDIR}/${CERT_DIR}

    install -m 600 ${B}/pki/private/${SERVER_NAME}.key ${STAGING_EASYRSA_BUILDDIR}/${CERT_DIR}
    install -m 600 ${B}/pki/issued/${SERVER_NAME}.crt ${STAGING_EASYRSA_BUILDDIR}/${CERT_DIR}

    #install -m 600 ${B}/pki/private/ca.key ${STAGING_EASYRSA_BUILDDIR}/${CERT_DIR}
    install -m 600 ${B}/pki/dh.pem ${STAGING_EASYRSA_BUILDDIR}/${CERT_DIR}
    install -m 600 ${B}/pki/ta.key ${STAGING_EASYRSA_BUILDDIR}/${CERT_DIR}

    if [ "${CLIENT_NAME}" ]; then
        install -d ${STAGING_EASYRSA_BUILDDIR}/${CERT_DIR}/client
        install -m 600 ${B}/pki/issued/${CLIENT_NAME}.crt ${STAGING_EASYRSA_BUILDDIR}/${CERT_DIR}/client
        install -m 600 ${B}/pki/private/${CLIENT_NAME}.key ${STAGING_EASYRSA_BUILDDIR}/${CERT_DIR}/client
    fi
}

do_install_class-native[cleandirs] += " ${STAGING_EASYRSA_BUILDDIR}"
do_install_class-native[cleandirs] += " ${B}/pki"

