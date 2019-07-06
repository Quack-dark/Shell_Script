#!/bin/bash
source /data/xBoxScript/func/run_func.sh
set -e

source $1

script_path="/data/xBoxScript/ver/"
if [ $# -lt 1 ]; then
	PrintRunErr "Usage: parameter too few"
fi

if [ "$action_target_dir" = "" ]; then
	PrintRunErr "restart_by_config path is empty"
fi

if [ "$action_exe" = "" ]; then
	PrintRunErr "restart_by_config exe is empty"
fi

count=$(ps -ef | grep $action_exe | grep -v "grep" | wc -l)
if [ $count -gt 0 ]; then
	for pid in $(ps -e | grep $action_exe | awk '{print $1}'); do
		for path in $(ls -l /proc/${pid}/cwd | awk '{print$11}'); do
			parent_dir="$path"/
			if [ $parent_dir == $action_target_dir ]; then
				old_pid=$pid
			fi
		done
	done
	if [ -n "$old_pid" ]; then
		source $script_path"start.sh" $action_target_dir $action_exe
		source $script_path"stop.sh" $old_pid
	fi
else
	source $script_path"start.sh" $action_target_dir $action_exe
fi

PrintRunInfo "restart by config $action_exe ok"
