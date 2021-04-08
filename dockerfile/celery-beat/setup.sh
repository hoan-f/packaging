#!/bin/bash

proj_path="$1"
proj_name=`basename $proj_path .py`
work_dir=`dirname $proj_path`

supervisord_conf=/tmp/supervisord.conf
schedule_db=/tmp/celerybeat-schedule

cd $work_dir || exit 1

cat >$supervisord_conf <<EOF
[supervisord]
nodaemon=true
logfile=/tmp/supervisord.log
pidfile=/tmp/supervisord.pid

[program:celery]
command=/usr/bin/celery -A $proj_name beat -s "$schedule_db" --pidfile=/tmp/celerybeat.pid
EOF

exec /usr/bin/supervisord -c $supervisord_conf
