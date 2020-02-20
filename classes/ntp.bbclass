
NTP_SERVERS ?= "0.pool.ntp.org 1.pool.ntp.org"
NTP_DRIFTFILE ?= "/var/lib/ntp/drift"

NTP_CONF ?= "${B}/my_ntp"

python create_ntpconf() {
    cfile = d.getVar('NTP_CONF')
    if not cfile:
        bb.fatal('Unable to read NTP_CONF')

    localdata = bb.data.createCopy(d)
    ntpservers = localdata.getVar('NTP_SERVERS').split()
    driftfile = localdata.getVar('NTP_DRIFTFILE')

    try:
        with open(cfile, 'w') as cfgfile:
            cfgfile.write('driftfile %s\n' %  driftfile)
            for server in ntpservers:
                cfgfile.write('server %s\n' %  server)

    except OSError:
        bb.fatal('Unable to open %s' % cfile)
}

do_compile[prefuncs] += "create_ntpconf"
