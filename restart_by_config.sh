#!/bin/bash
source $1
script_path="/data/xBoxScript/ver"
if [ $# -lt 1 ]; then
	echo "Usage: parameter too few"
	return
fi

for pid in `ps -e |grep $action_exe |awk '{print $1}'` ;
do
	for path in `ls -l /proc/${pid}/exe |awk '{print$11}'`;
	do
		parent_dir=`dirname $path`/
		if [ $parent_dir == $action_target_dir ]; then
			old_pid=$pid
		else
			echo "not found old pid"
		fi
	done
done

source start.sh $action_target_dir $action_exe

cd $script_path

source stop.sh $old_pid

echo "-------Restart $action_exe ok--------"
