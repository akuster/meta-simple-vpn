IFACE ?= "eth0"
IP_ADDRESS ?= "192.168.7.2"
IP_NETMASK ?= "255.255.255.0"
IP_GATEWAY ?= "192.168.7.1"
IP_NETWORK ?= "192.168.7.0"
IP_DNS_NAMESERVERS ?= "8.8.8.8"
IP_DNS_SEARCH ?= ""

MY_INTERFACE ?= "${B}/my_interfaces"

python create_interfaces() {
    cfile = d.getVar('MY_INTERFACE')
    if not cfile:
        bb.fatal('Unable to read MY_INTERFACE')

    localdata = bb.data.createCopy(d)
    ifaces = localdata.getVar('IFACE').split()
    addresses = localdata.getVar('IP_ADDRESS').split()

    netmask = localdata.getVar('IP_NETMASK')
    gateway = localdata.getVar('IP_GATEWAY')
    network = localdata.getVar('IP_NETWORK')
    nameservers = localdata.getVar('IP_DNS_NAMESERVERS')
    dns_search = localdata.getVar('IP_DNS_SEARCH')

    devs = len(ifaces)

    if devs != len(addresses):
        bb.fatal('More ifaces than defined addresses')

    try:
        with open(cfile, 'w') as cfgfile:
            # setup loopback
            cfgfile.write('\nauto lo\n')
            cfgfile.write('iface lo inet loopback\n')

            for i in range(0, devs):
                cfgfile.write('\nauto %s\n' % ifaces[i]) 
                cfgfile.write('iface %s inet static\n' % ifaces[i])
                cfgfile.write('address %s\n' % addresses[i])
                cfgfile.write('netmask %s\n' % netmask)
                cfgfile.write('gateway %s\n' % gateway)
                cfgfile.write('network %s\n' % network)
                cfgfile.write('dns-nameservers %s\n' % nameservers)
                cfgfile.write('dns-search %s\n\n' % dns_search)

    except OSError:
        bb.fatal('Unable to open %s' % cfile)
}

do_compile[prefuncs] += "create_interfaces"
