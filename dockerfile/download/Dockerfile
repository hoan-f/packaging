# Run download programs using supervisor
#
# For special use case only!
#
# Usage
#   docker run --name <container> \
#              -v /opt:/opt \
#              -v <collect_dir>:/data/collect \
#              -d <image>

FROM debian:latest

MAINTAINER Li Jiapeng "lijpbasin@126.com"

RUN echo "deb http://mirrors.ustc.edu.cn/debian jessie main contrib non-free" > /etc/apt/sources.list \
    && echo "deb http://security.debian.org/ jessie/updates main contrib non-free" >> /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y wget supervisor \
    && rm -rf /var/lib/apt/lists/* \
    && useradd -u 1000 -g 100 model

COPY supervisord.conf /etc/supervisor/supervisord.conf

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
