#!/bin/sh

/usr/sbin/rpcbind
#rpc.statd -L
#rpc.idmapd
/usr/bin/ganesha.nfsd -F -f /etc/ganesha/ganesha.conf -L STDOUT
