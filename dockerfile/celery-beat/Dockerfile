# Run periodic tasks using celery beat
#
# Usage
#   docker run --name <container> \
#              --link <redis_server>:redis \
#              -v ... \
#              -d <image> <task_module_path>

FROM supervisord

MAINTAINER Li Jiapeng "lijpbasin@126.com"

RUN echo "deb http://mirrors.ustc.edu.cn/debian jessie main contrib non-free" > /etc/apt/sources.list \
    && echo "deb http://security.debian.org/ jessie/updates main contrib non-free" >> /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y python-celery python-redis \
    && rm -rf /var/lib/apt/lists/*

COPY setup.sh /usr/local/bin/setup.sh

ENTRYPOINT ["/bin/bash", "/usr/local/bin/setup.sh"]
