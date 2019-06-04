#!/bin/bash
FullPath=$1
file=${FullPath##*/}
filename=${file%.*}
extension=${file##*.}
TargetTempDir="/home/llh/mytest/web/tmp"
NewFileName="$filename"_"$(date +%Y%m%d%k%M%S)"
if [ "$extension" == "zip" ]; then
	unzip -n -d $TargetTempDir $1
else
	echo "file ext is not zip"
fi
if [ "$(ls -a $TargetTempDir/$filename)" == "" ]; then
	echo "$TargetTempDir/$filename dir is empty"
else
	mv $TargetTempDir/$filename $TargetTempDir/$NewFileName
	mv $TargetTempDir/$NewFileName $2
fi
