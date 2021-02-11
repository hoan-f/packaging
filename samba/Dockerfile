# Set up anonymous samba file share service
#
# Usage
#   docker run --name <container> \
#              -p 135:135 -p 137-139:137-139 -p 445:445 \
#              -v <data_dir>:/data/samba \
#              -d <image>

FROM debian:latest

MAINTAINER Li Jiapeng "lijpbasin@126.com"

# Install SSH server and git, create /var/run/sshd for the SSH daemon
RUN echo "deb http://mirrors.ustc.edu.cn/debian jessie main contrib non-free" > /etc/apt/sources.list \
    && echo "deb http://security.debian.org/ jessie/updates main contrib non-free" >> /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y samba

COPY smb.conf /etc/samba/smb.conf

EXPOSE 137/udp 138/udp 139 445

CMD /usr/sbin/nmbd -D && /usr/sbin/smbd -F -S
