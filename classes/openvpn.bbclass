#
# This helps make the server.conf at build time.
#
#
# See https://github.com/OpenVPN/openvpn/blob/release/2.4/sample/sample-config-files/server.conf
# for more explaination
#
######
OPENVPN_SERVER_CONF ?= "${B}/server.conf"

VPN_SEVER_IFACE ?= "eth0"
VPN_CLIENT_SUBNET ?= "172.16.100"
VPN_PRIVATE_SUBNET ?= "192.168.9" 

VPN_SERVER_IP ?= "${VPN_CLIENT_SUBNET}.0"
VPN_NETMASK ?= "255.255.255.0"
VPN_CLIENT_START_IP ?= "${VPN_CLIENT_SUBNET}.1" 
VPN_PRIVATE_START_IP ?= "${VPN_PRIVATE_SUBNET}.1" 
VPN_PRIVATE_IFACE ?= "eth2"

VPN_LOCAL_IP ?= "192.168.18.40"
VPN_PORT ?= "1194"
VPN_PROTO ?= "udp"
VPN_DEV ?= "tun"
VPN_CA ?= "ca.crt"
VPN_CERT ?= "server.crt"
VPN_KEY ?= "server.key"
VPN_DH ?= "dh2048.pem"
VPN_TOPOLOGY ?= "subnet"
VPN_IFCONFIG ?= "${VPN_CLIENT_START_IP} ${VPN_PRIVATE_START_IP}"
VPN_ROUTES ?= "${VPN_IFCONFIG} ${VPN_CLIENT_SUBNET}.0 ${VPN_PRIVATE_SUBNET}.0"
VPN_IPCONFIG_POOL_PERSIST ?= "ipp.txt"
VPN_KEEPALIVE ?= "10 120"
VPN_TLS_AUTH ?= "ta.key 0"
VPN_KEY_DIRECTION ?= "0"
VPN_AUTH ?= "SHA256"
VPN_CIPHER ?= "AES-256-CBC"
VPN_COMP_LZO ?= "True"
VPN_CLIENT_TO_CLIENT ?= "True"
VPN_MAX_CLIENTS ?= "100"
VPN_USER ?= "nobody"
VPN_GROUP ?= "nobody"
VPN_PERSIST ?= "persist-key persist-tun"
VPN_STATUS ?= "/var/log/openvpn-status.log"
VPN_LOG ?= "openvpn.log"
VPN_LOG_VERBOSITY ?= "5"
VPN_SCRIPT_SECURITY ?= "2"
VPN_UP ?= "ifup.sh"
VPN_DOWN ?= "ifdown.sh"
VPN_SPRIPTS_DIR ?= "/etc/openvpn"

def create_openvpn_server_ifup(d):
    cfile = os.path.join(d.getVar('B'), d.getVar('VPN_UP'))
    if not cfile:
        bb.fatal('Unable to read VPN_UP')

    localdata = bb.data.createCopy(d)
    iface = localdata.getVar('VPN_PRIVATE_IFACE')

    try:
        with open(cfile, 'w') as cfgfile:
            cfgfile.write('#! /bin/sh\n')
            cfgfile.write('ifup %s\n' % iface)

    except OSError:
        bb.fatal('Unable to open %s' % cfile)

def create_openvpn_server_ifdown(d):
    cfile = os.path.join(d.getVar('B'), d.getVar('VPN_DOWN'))
    if not cfile:
        bb.fatal('Unable to read VPN_DOWN')

    localdata = bb.data.createCopy(d)
    iface = localdata.getVar('VPN_PRIVATE_IFACE')

    try:
        with open(cfile, 'w') as cfgfile:
            cfgfile.write('#! /bin/sh\n')
            cfgfile.write('ifdown %s\n' % iface)

    except OSError:
        bb.fatal('Unable to open %s' % cfile)

python create_openvpn_server_config() {
    cfile = d.getVar('OPENVPN_SERVER_CONF')
    if not cfile:
        bb.fatal('Unable to read OPENVPN_SERVER_CONF')

    localdata = bb.data.createCopy(d)

    netmask = localdata.getVar('VPN_IP_NETMASK')

    local = localdata.getVar('VPN_LOCAL_IP')
    port = localdata.getVar('VPN_PORT')
    proto = localdata.getVar('VPN_PROTO')
    dev = localdata.getVar('VPN_DEV')
    ca = localdata.getVar('VPN_CA')
    cert = localdata.getVar('VPN_CERT')
    key = localdata.getVar('VPN_KEY')
    dh = localdata.getVar('VPN_DH')
    topology = localdata.getVar('VPN_TOPOLOGY')
    server = localdata.getVar('VPN_SERVER_IP')
    ifconfig_pool_persist = localdata.getVar('VPN_IPCONFIG_POOL_PERSIST')
    routes = localdata.getVar('VPN_ROUTES').split()
    nameservers = localdata.getVar('VPN_IP_DNS_NAMESERVERS').split()
    client_to_client = localdata.getVar('VPN_CLIENT_TO_CLIENT')
    keepalive = localdata.getVar('VPN_KEEPALIVE')
    tls_auth = localdata.getVar('VPN_TLS_AUTH')
    key_direction = localdata.getVar('VPN_KEY_DIRECTION')
    auth = localdata.getVar('VPN_AUTH')
    cipher = localdata.getVar('VPN_CIPHER')
    comp_lzo = localdata.getVar('VPN_COMP_LZO')
    max_clients = localdata.getVar('VPN_MAX_CLIENTS')
    user = localdata.getVar('VPN_USER')
    group =localdata.getVar('VPN_GROUP')
    persists = localdata.getVar('VPN_PERSIST').split()
    status = localdata.getVar('VPN_STATUS')
    log =localdata.getVar('VPN_LOG')
    log_verbosity =localdata.getVar('VPN_LOG_VERBOSITY')
    script_security = localdata.getVar('VPN_SCRIPT_SECURITY')
    up = localdata.getVar('VPN_UP')
    down = localdata.getVar('VPN_DOWN')

    ifconfig = localdata.getVar('VPN_IFCONFIG')
    netmask = localdata.getVar('VPN_IP_NETMASK')

    try:
        with open(cfile, 'w') as cfgfile:
            cfgfile.write('local %s\n' % local)
            cfgfile.write('port %s\n' % port)
            cfgfile.write('proto %s\n' % proto)
            cfgfile.write('dev %s\n' % dev)
            cfgfile.write('\nca  %s\n' % ca)
            cfgfile.write('cert %s\n' % cert)
            cfgfile.write('key  %s\n' % key)
            cfgfile.write('dh  %s\n' % dh)
            cfgfile.write('\ntopology %s\n' % topology)
            cfgfile.write('\nserver %s %s\n' %(server, netmask))
            cfgfile.write('ifconfig-pool-persist %s\n' % ifconfig_pool_persist)
            cfgfile.write('\nifconfig %s\n' % ifconfig)
            # create routes
            for route in routes:
                cfgfile.write('push "route %s %s"\n' %(route, netmask))
            cfgfile.write('\n')

            for nameserver in nameservers:
                cfgfile.write('push "dhcp-option DNS %s"\n' % nameserver )

            cfgfile.write('\n')

            if client_to_client:
                cfgfile.write('client-to-client\n')

            cfgfile.write('keepalive %s\n' % keepalive)
            cfgfile.write('tls-auth %s\n' % tls_auth)
            cfgfile.write('key-direction %s\n' % key_direction)
            cfgfile.write('auth %s\n' % auth)
            cfgfile.write('cipher %s\n' % cipher)

            if comp_lzo:
                cfgfile.write('comp_lzo \n')

            cfgfile.write('max-clients %s\n' % max_clients)
            cfgfile.write('user  %s\n' % user )
            cfgfile.write('group  %s\n' % group )

            for persist in persists:
                cfgfile.write('%s\n' % persist)

            cfgfile.write('status %s\n' % status)
            cfgfile.write('log %s\n' % log)
            cfgfile.write('verb %s\n' % log_verbosity)
            cfgfile.write('script-security %s\n' % script_security)
            cfgfile.write('up "%s"\n' % up)
            cfgfile.write('down  "%s"\n' % down )
            
    except OSError:
        bb.fatal('Unable to open %s' % cfile)

    if up:
        create_openvpn_server_ifup(d)

    if down:
        create_openvpn_server_ifdown(d)

        
}

do_compile[prefuncs] += "create_openvpn_server_config"
