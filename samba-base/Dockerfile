# Base image for samba services
#

FROM debian:latest

MAINTAINER Li Jiapeng "lijpbasin@126.com"

# Install SSH server and git, create /var/run/sshd for the SSH daemon
RUN echo "deb http://mirrors.ustc.edu.cn/debian jessie main contrib non-free" > /etc/apt/sources.list \
    && echo "deb http://security.debian.org/ jessie/updates main contrib non-free" >> /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y samba

COPY smb.conf /etc/samba/smb.conf
