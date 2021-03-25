#!/bin/bash

OMITDIR=/run/sendsigs.omit.d
NFS_ROOT=/exports
ORDERED_SERVICES=(rpcbind nfs-common nfs-kernel-server)
N_SERVICES=${#ORDERED_SERVICES[@]}

trap 'stop_services; exit' SIGTERM SIGINT

stop_services() {
    local i=
    for i in `eval echo {$((N_SERVICES-1))..0}`
    do
        local svc=${ORDERED_SERVICES[i]}
        echo "Stopping $svc"
        service $svc stop
    done
}

start_services() {
    local i=
    for i in `eval echo {0..$((N_SERVICES-1))}`
    do
        local svc=${ORDERED_SERVICES[i]}
        echo "Starting $svc"
        service $svc start
    done
}

start_monitor() {
    LOG_FIFO=/tmp/exports_log.fifo
    mkfifo $LOG_FIFO
    inotifywait -o $LOG_FIFO -m $NFS_ROOT -r &
    INOTIFY_PID=$!
    echo "Started inotifywait in the background"
    while true; do
        sleep 1
        echo >$LOG_FIFO
    done &
}

mkdir -p "$OMITDIR"

start_services

start_monitor

while true; do
    if read -t 1 line <$LOG_FIFO; then
        [ "$line" ] && echo "$line"
    fi
done
