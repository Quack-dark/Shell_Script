#!/bin/bash
##这里必须使用绝对路径
source /data/xBoxScript/func/run_func.sh
set -e

if [ $# -lt 1 ]; then
	PrintRunErr "Usage: parameter too few"
fi

if [ ! -n "$(echo $1 | sed -n "/^[0-9]\+$/p")" ]; then

	for pid in $(ps -e | grep $2 | awk '{print $1}'); do
		for path in $(ls -l /proc/${pid}/exe | awk '{print$11}'); do
			parent_dir=$(dirname $path)/
			if [ $parent_dir == $1 ]; then
				kill -9 $pid
			fi
		done
	done
	PrintRunInfo  "stop $2 ok"
else
	kill -9 $1
	PrintRunInfo  "stop pid: $1 ok"
fi

