#!/bin/bash
target_path=$1
target_exe=$2

cd $target_path

./$target_exe &
