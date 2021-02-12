# Set up anonymous samba NetBIOS name service
#
# !!! This service currently works unexpectedly inside a docker !!!
#
# Usage
#   docker run --name <container> \
#              -p 137-138:137-138/udp \
#              -d <image>

FROM samba-base

MAINTAINER Li Jiapeng "lijpbasin@126.com"

EXPOSE 137/udp 138/udp

CMD /usr/sbin/nmbd -F -S
