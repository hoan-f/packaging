# Set up anonymous samba file share service
#
# Usage
#   docker run --name <container> \
#              -p 139:139 -p 445:445 \
#              -v <data_dir>:/data/samba \
#              -d <image>

FROM samba-base

MAINTAINER Li Jiapeng "lijpbasin@126.com"

EXPOSE 139 445

CMD /usr/sbin/smbd -F -S
