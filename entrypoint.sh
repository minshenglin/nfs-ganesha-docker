#!/bin/bash

config_path="/etc/ganesha/ganesha.conf"

# check ganesha config variable
if [[ -z "${GANESHA_CONFIG_POOL}" || -z "${GANESHA_CONFIG}" ]]; then
	echo "GANESHA_CONFIG_POOL and GANESHA_CONFIG is not set"
	exit 1
fi

# start rpcbind
/usr/sbin/rpcbind
/usr/sbin/rpc.statd -L
/usr/sbin/rpc.idmapd

mkdir -p /etc/ganesha

echo "RADOS_URLS {
	ceph_conf = /etc/ceph/ceph.conf;
	userid = admin;
}

%url rados://$GANESHA_CONFIG_POOL/$GANESHA_CONFIG

NFSv4 {
	Delegations = false;
        RecoveryBackend = rados_ng;
        Minor_Versions =  1,2;
}

RGW {
        ceph_conf = /etc/ceph/ceph.conf;
        name = \"client.admin\";
        cluster = ceph;
        init_args = \"--keyring=/etc/ceph/ceph.client.admin.keyring\";
}" > $config_path

cat $config_path

# start nfs-ganesha
/usr/bin/ganesha.nfsd -F -f $config_path -L STDOUT
