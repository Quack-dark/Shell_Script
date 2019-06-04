#!/bin/bash
source $1
target_dir=$action_target_dir

cd $target_dir

./$action_exe
