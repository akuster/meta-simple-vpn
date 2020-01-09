
IP_DNS_NAMESERVERS ?= "8.8.8.8"
IP_DNS_SEARCH ?= ""

MY_BASE ?= "${B}/my_base"

python create_resolvconf() {
    cfile = d.getVar('MY_BASE')
    if not cfile:
        bb.fatal('Unable to read MY_BASE')

    localdata = bb.data.createCopy(d)
    nameservers = localdata.getVar('IP_DNS_NAMESERVERS').split()
    dns_search = localdata.getVar('IP_DNS_SEARCH')

    try:
        with open(cfile, 'w') as cfgfile:
            for nameserver in nameservers:
                cfgfile.write('nameserver %s\n' %  nameserver)
            cfgfile.write('search %s\n' % dns_search)

    except OSError:
        bb.fatal('Unable to open %s' % cfile)
}

do_compile[prefuncs] += "create_resolvconf"
