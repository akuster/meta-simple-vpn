SUMMARY = "easy-rsa is a CLI utility to build and manage a PKI CA. In laymen's terms, this means to create a root certificate authority, and request and sign certificates, including sub-CAs and certificate revokation lists (CRL)."
HOMEPAGE = "http://openvpn.net"
LIC_FILES_CHKSUM = "file://Licensing/gpl-2.0.txt;md5=75859989545e37968a99b631ef42722e"
LICENSE = "GPLv2"
SECTION = "Security/Cryptography"

DEPENDS_class-native = "openssl-native"

SRCREV = "4152244bae2101018410df952e0bc00049947f8a"
SRC_URI = "git://github.com/OpenVPN/easy-rsa.git;branch='v${PV}'"

S = "${WORKDIR}/git"

inherit autotools

KEY_SIZE="2048"

# days to expire
CA_EXPIRE="3650"

# days to expire
KEY_EXPIRE="3650"

KEY_COUNTRY="US"
KEY_PROVINCE="CA"
KEY_CITY="SanJose"
KEY_ORG="Pono"
KEY_EMAIL="akuster@kama-aina.net"
KEY_OU="Kimo"
KEY_NAME="server"

do_compile() {
        src_files="easyrsa3/ Licensing/ COPYING.md ChangeLog README.md README.quickstart.md"
        for f in $src_files
        do
                cp -a ${S}/$f ${B} 
        done

        cp -R ${S}/doc ${B} 

        #sed -i -e "s/~~~//" "${B}/easyrsa3/easyrsa"
}


do_compile2_append() {
	sed -i -e 's:KEY_SIZE=.*$:KEY_SIZE=${KEY_SIZE}:' ${S}/easy-rsa/2.0/vars
	sed -i -e 's:KEY_EXPIRE=.*$:KEY_EXPIRE=${KEY_EXPIRE}:' ${S}/easy-rsa/2.0/vars
	sed -i -e 's:CA_EXPIRE=.*$:CA_EXPIRE=${CA_EXPIRE}:' ${S}/easy-rsa/2.0/vars
	sed -i -e 's:KEY_COUNTRY=.*$:KEY_COUNTRY="${KEY_COUNTRY}":' ${S}/easy-rsa/2.0/vars
	sed -i -e 's:KEY_PROVINCE=.*$:KEY_PROVINCE="${KEY_PROVINCE}":'  ${S}/easy-rsa/2.0/vars
 	sed -i -e 's:KEY_CITY=.*$:KEY_CITY="${KEY_CITY}":' ${S}/easy-rsa/2.0/vars
 	sed -i -e 's:KEY_ORG=.*$:KEY_ORG="${KEY_ORG}":' ${S}/easy-rsa/2.0/vars
 	sed -i -e 's:KEY_EMAIL=.*$:KEY_EMAIL="${KEY_EMAIL}":' ${S}/easy-rsa/2.0/vars
 	sed -i -e 's:KEY_OU=.*$:KEY_OU="${KEY_OU}":' ${S}/easy-rsa/2.0/vars
	sed -i -e 's:KEY_NAME=.*$:KEY_NAME="${KEY_NAME}":' ${S}/easy-rsa/2.0/vars
}

do_install () {
	install -d ${D}/${sysconfdir}/openvpn/easyrsa3
	cp -R ${B}/easyrsa3 ${D}/${sysconfdir}/openvpn
}

RDEPENDS_${PN} = "openssl"
