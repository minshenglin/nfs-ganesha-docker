FROM centos:7

COPY ceph.repo /etc/yum.repos.d/ceph.repo
COPY nfs.repo /etc/yum.repos.d/nfs.repo
COPY ganesha.conf /etc/ganesha/ganesha.conf
RUN yum install -y epel-release
RUN rpm --import 'https://download.ceph.com/keys/release.asc'
EXPOSE 2049
RUN yum install nfs-ganesha-rgw -y
COPY entrypoint.sh /tmp/entrypoint.sh
ENTRYPOINT "/tmp/entrypoint.sh"
