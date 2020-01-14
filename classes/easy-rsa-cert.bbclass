#
#
#

# Defaults in package
EASYRSA_OPENSSL ?= "openssl"
EASYRSA_DIR     ?= "${sysconfdir}/easyrsa3"
EASYRSA_PKI ?= "${B}/pki"
EASYRSA_DN  ?= "cn_only"
EASYRSA_REQ_COUNTRY ?= "US"
EASYRSA_REQ_PROVINCE    ?= "California"
EASYRSA_REQ_CITY    ?= "San Francisco"
EASYRSA_REQ_ORG     ?= "Copyleft Certificate Co"
EASYRSA_REQ_EMAIL   ?= "me@example.net"
EASYRSA_REQ_OU      ?= "My Organizational Unit"
EASYRSA_ALGO        ?= "rsa"
EASYRSA_KEY_SIZE    ?= "2048"
EASYRSA_CURVE       ?= "secp384r1"
EASYRSA_EC_DIR      ?= "${EASYRSA_PKI}/ecparams"
EASYRSA_CA_EXPIRE   ?= "3650"
EASYRSA_CERT_EXPIRE ?= "1080" 
EASYRSA_CRL_DAYS    ?= "180"
EASYRSA_REQ_CN      ?= "ChangeMe"
EASYRSA_DIGEST      ?= "sha256"
EASYRSA_EXT_DIR     ?= "${EASYRSA_DIR}/x509-types"
EASYRSA_SSL_CONF    ?= "${EASYRSA_DIR}/openssl-easyrsa.cnf"
#EASYRSA_SAFE_CONF   ?= "${EASYRSA_DIR}/safessl-easyrsa.cnf"

EASYRSA_VARS_FILE ?= "easy-rsa.vars"

python create_easy_rsa_vars() {

    cfile = os.path.join(d.getVar('B'),d.getVar('EASYRSA_VARS_FILE'))
    if not cfile:
        bb.fatal('Unable to read EASYRSA_VARS_FILE')

    localdata = bb.data.createCopy(d)

    openssl = localdata.getVar('EASYRSA_OPENSSL')
    pki_dir = localdata.getVar('EASYRSA_PKI')
    dn = localdata.getVar('EASYRSA_DN')
    country = localdata.getVar('EASYRSA_REQ_COUNTRY')
    province = localdata.getVar('EASYRSA_REQ_PROVINCE')
    city = localdata.getVar('EASYRSA_REQ_CITY')
    org = localdata.getVar('EASYRSA_REQ_ORG')
    email = localdata.getVar('EASYRSA_REQ_EMAIL')
    ou = localdata.getVar('EASYRSA_REQ_OU')
    algo = localdata.getVar('EASYRSA_ALGO')
    key_size = localdata.getVar('EASYRSA_KEY_SIZE')
    curve = localdata.getVar('EASYRSA_CURVE')
    ec_dir = localdata.getVar('EASYRSA_EC_DIR')
    ca_expire = localdata.getVar('EASYRSA_CA_EXPIRE')
    cert_expire = localdata.getVar('EASYRSA_CERT_EXPIRE')
    crl_days = localdata.getVar('EASYRSA_CRL_DAYS')
    req_cn = localdata.getVar('EASYRSA_REQ_CN')
    digest = localdata.getVar('EASYRSA_DIGEST')

    ext_dir = localdata.getVar('EASYRSA_EXT_DIR')
    ssl_conf = localdata.getVar('EASYRSA_SSL_CONF')

    try:
        with open(cfile, 'w') as cfgfile:
            cfgfile.write('set_var EASYRSA_PKI %s\n' % pki_dir)
            cfgfile.write('set_var EASYRSA_OPENSSL %s\n' % openssl)
            cfgfile.write('set_var EASYRSA_DN  %s\n' % dn)
            cfgfile.write('set_var EASYRSA_REQ_COUNTRY "%s"\n' % country)
            cfgfile.write('set_var EASYRSA_REQ_PROVINCE    "%s"\n' % province)
            cfgfile.write('set_var EASYRSA_REQ_CITY    "%s"\n' % city)
            cfgfile.write('set_var EASYRSA_REQ_ORG     "%s"\n' % org)
            cfgfile.write('set_var EASYRSA_REQ_EMAIL   %s\n' % email)
            cfgfile.write('set_var EASYRSA_REQ_OU      "%s"\n' % ou)
            cfgfile.write('set_var EASYRSA_ALGO        %s\n' % algo)
            cfgfile.write('set_var EASYRSA_KEY_SIZE    %s\n' % key_size)
            cfgfile.write('set_var EASYRSA_CURVE       %s\n' % curve)
            cfgfile.write('set_var EASYRSA_EC_DIR      %s\n' % ec_dir)
            cfgfile.write('set_var EASYRSA_CA_EXPIRE   %s\n' % ca_expire)
            cfgfile.write('set_var EASYRSA_CERT_EXPIRE %s\n' % cert_expire)
            cfgfile.write('set_var EASYRSA_REQ_CN      %s\n' % req_cn)
            cfgfile.write('set_var EASYRSA_DIGEST      %s\n' % digest)
            cfgfile.write('set_var EASYRSA_EXT_DIR %s\n' % ext_dir )
            cfgfile.write('set_var EASYRSA_SSL_CONF %s\n' %  ssl_conf)

    except OSError:
        bb.fatal('Unable to open %s' % cfile)
            
}

do_compile[prefuncs] += "create_easy_rsa_vars"
