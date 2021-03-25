# Run network file server
#
# Usage
#   docker run --name <container> \
#              --privileged \
#              -v <data_dir>:/exports \
#              -d <image>
#
#  Inspired by cpuguy83's docker-nfs-server
#
#    https://github.com/cpuguy83/docker-nfs-server
#
#  Option --privileged is required to mount /proc/fs/nfsd, this
#  option can be replaced with the safer --cap-add=SYS_ADMIN option
#  on hosts without AppArmor. See ErezHorev's solution:
#
#    https://github.com/ErezHorev/dockerized_nfs_server
#
#  Do not publish 111 or 2049 port to the host interface, serving
#  NFS directories from the host should be done by nfs server
#  running on the host.
#  If the host needs to mount NFS directories from the docker
#  container, it should also start rpcbind, which uses the 111 port
#  of the host.
#
#  Client recovery does not work properly (does not prevent NFS
#  server from working) and shows the following error message:
#
#    NFSD: Unable to initialize client recovery tracking! (-22)

FROM debian:latest

MAINTAINER Li Jiapeng "lijpbasin@126.com"

RUN echo "deb http://mirrors.ustc.edu.cn/debian jessie main contrib non-free" > /etc/apt/sources.list \
    && echo "deb http://security.debian.org/ jessie/updates main contrib non-free" >> /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y nfs-kernel-server inotify-tools

EXPOSE 111/udp 2049/tcp

COPY exports /etc/exports
COPY start-nfs.sh /usr/local/sbin/start-nfs.sh

CMD ["/bin/bash", "/usr/local/sbin/start-nfs.sh"]
