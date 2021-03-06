# Serve static html site and git repository (via cgit)
#
# Usage
#   docker run --name <container> -p <http_port>:80 \
#              -v <repo_dir>:/git:ro \
#              -v <web_root_dir>:/usr/share/nginx/html:ro \
#              -d <image>
#
# To update git repo list:
#   docker cp <cgitrepo_file> <container>:/etc/cgitrepos

FROM nginx:latest

MAINTAINER Li Jiapeng "lijpbasin@126.com"

# Install
#   fcgiwrap: Communicate between cgit (CGI) and nginx (FastCGI)
#   python-pygments: Highlight source code
RUN echo "deb http://mirrors.ustc.edu.cn/debian jessie main contrib non-free" > /etc/apt/sources.list \
    && echo "deb http://security.debian.org/ jessie/updates main contrib non-free" >> /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y fcgiwrap python-pygments cgit \
    && touch /etc/cgitrepos \
    && rm -rf /var/lib/apt/lists/*

# Create /git for git repositories
RUN mkdir /git

# Apply the default config files (Setting that makes cgit work)
COPY nginx_site.conf /etc/nginx/conf.d/default.conf
COPY cgitrc /etc/cgitrc

# Run fcgiwrap and nginx
CMD spawn-fcgi -U nginx -G nginx -s /var/run/fcgiwrap.socket /usr/sbin/fcgiwrap \
    && nginx -g "daemon off;"
