#!/bin/bash

proj_path="$1"
proj_name=`basename $proj_path .py`
work_dir=`dirname $proj_path`

cd $work_dir || exit 1

cat >supervisord.conf <<EOF
[supervisord]
nodaemon=true
logfile=/tmp/supervisord.log
pidfile=/tmp/supervisord.pid

[program:celery]
command=/usr/bin/celery -A $proj_name beat
EOF

exec /usr/bin/supervisord
