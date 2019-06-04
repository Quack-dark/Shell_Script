#!/bin/bash
source $1
FullPath=$1
dir=$(dirname ${FullPath})
base=$(basename ${FullPath})

cd $dir

./$base
