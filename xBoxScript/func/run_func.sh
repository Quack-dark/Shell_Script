#!/bin/bash

function PrintRunInfo() {
    time=$(date "+%Y-%m-%d %H:%M:%S")
    echo "$time : $1" >>/data/logs/ver_info.log
}

function PrintRunErr() {
    time=$(date "+%Y-%m-%d %H:%M:%S")
    echo "$time : $1" >>/data/logs/ver_err.log
    exit 1
}

function ReadINIfile() {
    if [ $# -lt 3 ]; then
        PrintRunErr "ReadINIfile parameter too few (0)"
    fi

    key=$1
    section=$2
    configfile=$3

    if [ ! -f $configfile ]; then
        PrintRunErr "ReadINIfile parameter too few (1)"
    fi

    ReadINI=$(awk -F '=' '/\['$section'\]/{a=1}a==1&&$1~/'$key'/{print $2;exit}' $configfile)

    if [ "$ReadINI" == "" ]; then
        PrintRunErr "ReadINI Error"
    fi

    echo "$ReadINI"
}
