#!/bin/bash
source /data/xBoxScript/func/run_func.sh
set -e

if [ $# -lt 1 ]; then
	PrintRunErr "Usage: parameter too few"
fi

source $1
target_dir=$action_target_dir

if [ "$target_dir" = "" ]; then
	PrintRunErr "start_by_config.sh target_dir is empty"
fi
cd $target_dir

if [ "$action_exe" = "" ]; then
	PrintRunErr "start_by_config.sh action_exe is empty"
fi
./$action_exe &

PrintRunInfo  "start by config $action_exe ok"