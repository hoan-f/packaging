# Run programs using supervisor
#
# Usage
#   docker run --name <container> \
#              -v ... \
#              -d <image> <config_path>

FROM debian:latest

MAINTAINER Li Jiapeng "lijpbasin@126.com"

RUN echo "deb http://mirrors.ustc.edu.cn/debian jessie main contrib non-free" > /etc/apt/sources.list \
    && echo "deb http://security.debian.org/ jessie/updates main contrib non-free" >> /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y supervisor \
    && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/usr/bin/supervisord", "-c"]
