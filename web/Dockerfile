# Serve static html site and git repository (via cgit)
#
# Usage
#   docker run --name <container> -p 80:80 \
#              -v /data/code:/git:ro \
#              -v /data/web:/usr/share/nginx/html:ro \
#              -d <image>

FROM nginx:latest

MAINTAINER jpli "lijpbasin@126.com"

# Install
#   fcgiwrap: Communicate between cgit (CGI) and nginx (FastCGI)
#   python-pygments: Highlight source code
RUN echo "deb http://mirrors.ustc.edu.cn/debian jessie main contrib non-free" > /etc/apt/sources.list \
    && echo "deb http://security.debian.org/ jessie/updates main contrib non-free" >> /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y fcgiwrap python-pygments cgit \
    && rm -rf /var/lib/apt/lists/*

# Create /git for git repositories
RUN mkdir /git

# Apply the default config files (Setting that makes cgit work)
COPY nginx_site.conf /etc/nginx/conf.d/default.conf
COPY cgitrc /etc/cgitrc

# Run fcgiwrap and nginx
CMD spawn-fcgi -U nginx -G nginx -s /var/run/fcgiwrap.socket /usr/sbin/fcgiwrap \
    && nginx -g "daemon off;"
