#!/bin/bash
target_path=$1
target_exe=$2

source /data/xBoxScript/func/run_func.sh
set -e

if [ $# -lt 1 ]; then
    PrintRunErr "Usage: parameter too few"
fi

if [ "$target_path" = "" ]; then
    PrintRunErr "start.sh target_path is empty"
fi
cd $target_path

if [ "$target_exe" = "" ]; then
    PrintRunErr "start.sh target_exe is empty"
fi

./$target_exe &

PrintRunInfo "start $target_exe ok"
