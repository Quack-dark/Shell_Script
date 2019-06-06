#!/bin/bash
if [ $# -lt 1 ]; then
	echo "Usage: parameter too few"
	return
fi
source $1
target_dir=$action_target_dir

cd $target_dir

./$action_exe &
