#!/bin/bash
source $1
source /data/xBoxScript/func/run_func.sh
source /data/xBoxScript/func/ver_func.sh
set -e

if [ $# -lt 1 ]; then
	PrintRunErr "Usage: too few paramter"
fi

FullPath=$action_new_pkg
file=${FullPath##*/}
filename=${file%.*}
extension=${file##*.}
TargetTempDir=$TempDir
NewFileName="$filename"_"$(date +%Y%m%d%k%M%S)"
if [ "$extension" == "zip" ]; then
	unzip -o -d $TargetTempDir/$filename $FullPath
else
	PrintRunErr "file ext is not zip"
fi
if [ "$(ls -a $TargetTempDir/$filename)" == "" ]; then
	PrintRunErr "$TargetTempDir/$filename dir is empty"
else
	mv "$TargetTempDir/$filename" $TargetTempDir/$NewFileName
	funcMVFolder $TargetTempDir/$NewFileName/ $action_target_dir

	rm -rf $TargetTempDir/$NewFileName/

	chmod +x "$action_target_dir"$action_exe
fi

PrintRunInfo "update by config $filename ok"
