# Generate ikiwiki static site
#
# Usage
#   docker run -v <doc_src_dir>:/var/lib/ikiwiki/src \
#              -v <doc_html_dir>:/var/lib/ikiwiki/target \
#              <image>

FROM debian:latest

MAINTAINER Li Jiapeng "lijpbasin@126.com"

# Install ikiwiki
RUN echo "deb http://mirrors.ustc.edu.cn/debian jessie main contrib non-free" > /etc/apt/sources.list \
    && echo "deb http://security.debian.org/ jessie/updates main contrib non-free" >> /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y ikiwiki \
    && rm -rf /var/lib/apt/lists/*

# Create ikiwiki IO directories
RUN mkdir -p /var/lib/ikiwiki/src /var/lib/ikiwiki/target

# Add a default ikiwiki setup
COPY ikiwiki.setup /var/lib/ikiwiki/ikiwiki.setup

# Run ikiwiki and apply the ownership of the target directory to its content
CMD /usr/bin/ikiwiki --setup /var/lib/ikiwiki/ikiwiki.setup \
    && chown -R `stat -c '%u:%g' /var/lib/ikiwiki/target` /var/lib/ikiwiki/target/*
