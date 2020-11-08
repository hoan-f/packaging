# Serve git repositories via the SSH protocol
#
# Usage
#   docker run --name <container> -p 8022:22 \
#              -v /data/code:/git \
#              -v /home/git:/home/git \
#              -d <image>

FROM debian:latest

MAINTAINER Li Jiapeng "lijpbasin@126.com"

# Install SSH server and git, create /var/run/sshd for the SSH daemon
RUN echo "deb http://mirrors.ustc.edu.cn/debian jessie main contrib non-free" > /etc/apt/sources.list \
    && echo "deb http://security.debian.org/ jessie/updates main contrib non-free" >> /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y openssh-server git \
    && mkdir /var/run/sshd \
    && rm -rf /var/lib/apt/lists/*

# Add user git and create code directory /git
RUN groupadd -g 2001 git \
    && useradd -u 2001 -g 2001 -s /usr/bin/git-shell -d /home/git -m git \
    && mkdir /git

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
