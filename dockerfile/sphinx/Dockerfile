# Generate sphinx html documentation
#
# Usage
#   docker run -v <doc_src_dir>:/var/lib/sphinx/src \
#              -v <doc_html_dir>:/var/lib/sphinx/target \
#              <image>

FROM debian:latest

MAINTAINER Li Jiapeng "lijpbasin@126.com"

# Install ikiwiki
RUN echo "deb http://mirrors.ustc.edu.cn/debian jessie main contrib non-free" > /etc/apt/sources.list \
    && echo "deb http://security.debian.org/ jessie/updates main contrib non-free" >> /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y python-sphinx \
    && rm -rf /var/lib/apt/lists/*

# Create sphinx source and target mountpoints
RUN mkdir -p /var/lib/sphinx/src /var/lib/sphinx/target

# Run ikiwiki and apply the ownership of the target directory to its content
CMD /usr/bin/sphinx-build -b html -d /tmp/doctrees /var/lib/sphinx/src /var/lib/sphinx/target \
    && chown -R `stat -c '%u:%g' /var/lib/sphinx/target` /var/lib/sphinx/target/*
