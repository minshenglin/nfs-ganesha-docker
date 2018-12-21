FROM centos:7

COPY ceph.repo /etc/yum.repos.d/ceph.repo
COPY nfs.repo /etc/yum.repos.d/nfs.repo

RUN yum install -y epel-release
RUN rpm --import 'https://download.ceph.com/keys/release.asc'
RUN yum install nfs-ganesha-ceph nfs-ganesha-rgw -y

EXPOSE 2049

COPY entrypoint.sh /tmp/entrypoint.sh
ENTRYPOINT "/tmp/entrypoint.sh"
