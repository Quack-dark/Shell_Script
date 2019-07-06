#!/bin/bash

set -e
source /data/xBoxScript/func/run_func.sh

prefix_path="/data/xBoxScript/ver/"
prefix_run_path="/data/ver/run/"
prefix_tmpbak_path="/data/ver/run_bak"
prefix_config_path="/data/ver/pkg/"

LOCK_FILE="/data/xBoxScript/crontab/run_xBox.lock"

trap "rm -rf $LOCK_FILE" exit ERR

if [ ! -f "$LOCK_FILE" ]; then
	touch "$LOCK_FILE"
else
	PrintRunInfo "Lock file already exist"
	exit 0
fi

file_num=$(ls -l $prefix_run_path | grep .ini | grep "^-" | wc -l)

for ((j = 1; j <= $file_num; j++)); do
	new_file=$(ls -lt --time-style='+%y-%m-%d %H:%M:%S' $prefix_run_path | grep .ini | head -1 | awk '{print $8}')
	if [ "$new_file" = "" ]; then
		PrintRunInfo "The earliest .Ini file is empty"
	fi
	config_path=$prefix_run_path"$new_file"
	cmd_nums=$(ReadINIfile "command_nums" "cmd_num" "$config_path")
	if [ $cmd_nums -eq 0 ]; then
		PrintRunErr "command_nums too few"
	fi
	for ((i = 1; i <= $cmd_nums; i++)); do
		cmd_section="command""$i"
		if [ "$cmd_section" = "" ]; then
			PrintRunErr "command section error"
		fi
		cmd_key=$(ReadINIfile "cmd" "$cmd_section" "$config_path")
		if [ "$cmd_key" = "" ]; then
			PrintRunErr "command key error"
		fi
		parameter=$(ReadINIfile "param" "$cmd_section" "$config_path")
		if [ "$parameter" = "" ]; then
			PrintRunErr "command parameter error"
		fi
		param_count=$(echo $parameter | awk '{print NF}')
		if [ $param_count -eq 1 ]; then
			if [ ! -n "$(echo $parameter | sed -n "/^[0-9]\+$/p")" ]; then
				source "$prefix_path"$cmd_key "$prefix_config_path"$parameter
			else
				source "$prefix_path"$cmd_key $parameter
			fi
		else
			source "$prefix_path"$cmd_key $parameter
		fi
	done
	mv "$prefix_run_path"$new_file $prefix_tmpbak_path
done

rm -rf $LOCK_FILE