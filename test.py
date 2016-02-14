real_domain='default'

name             = 'CustomerA'
channel          = 'PartitionChannel'
target           = 'WebCluster'
targettype       = 'Cluster'
host_names       = '10.10.10.100,10.10.10.200'
port             = '8011'
portoffset       = ''
uriprefix        = '/customer_a'

edit()
startEdit()

try:

    cd('/')
    cmo.createVirtualTarget(name)
    cd('/VirtualTargets/'+name)
    print '1'
    if channel:
        set('PartitionChannel',channel)
    print '2'

    if portoffset:
        set('PortOffset',portoffset)
    print '3'

    if port:
        set('ExplicitPort',port)
    print '4'

    if uriprefix:
        set('UriPrefix',uriprefix)
    print '5'

    if host_names:
        hosts = String(vhost_names).split(",")
        set('HostNames',jarray.array(hosts, String))
    print '5'

    print "target " + target + " " + targettypes
    targetaa = ObjectName('com.bea:Name=' + target + ',Type='+ targettype)

    print '6'

    set('Target',targetaa)
    print '7'

    save()
    activate()
    print "~~~~COMMAND SUCCESFULL~~~~"

except:
    print "Unexpected error:", sys.exc_info()[0]
    undo('true','y')
    stopEdit('y')
    print "~~~~COMMAND FAILED~~~~"
    raise

