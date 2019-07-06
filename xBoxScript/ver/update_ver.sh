#!/bin/bash
source /data/xBoxScript/func/ver_func.sh
source /data/xBoxScript/func/run_func.sh
set -e

FullPath=$1
file=${FullPath##*/}
filename=${file%.*}
extension=${file##*.}
TargetTempDir="/data/ver/pkg_tmp"
NewFileName="$filename"_"$(date +%Y%m%d%k%M%S)"
if [ $# -lt 2 ]; then
	PrintRunErr "Usage: too few paramter"
fi

if [ "$extension" == "zip" ]; then
	unzip -o -d $TargetTempDir/$filename $1
else
	PrintRunErr "file ext is not zip"
fi
if [ "$(ls -a $TargetTempDir/$filename)" == "" ]; then
	PrintRunErr "$TargetTempDir/$filename dir is empty"
else
	mv "$TargetTempDir/$filename" $TargetTempDir/$NewFileName
	funcMVFolder $TargetTempDir/$NewFileName/ $2

	rm -rf $TargetTempDir/$NewFileName/

	chmod +x "$2"$3
fi

PrintRunInfo "update $filename ok"
