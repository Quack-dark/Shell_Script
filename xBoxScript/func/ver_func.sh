#!/bin/bash

function PrintInfo() {

    echo "$1" >>/data/xBoxScript/log/ver_info.log
}

function PrintErr() {

    echo "$1" >>/data/xBoxScript/log/ver_err.log
	exit 1
}

function funcMV {
	for name in $1*
	do
		if [ -d "$name" ]
		then 
			funcMV $name/ $2 $3
		elif [ -f "$name" ]
		then 
			c=$2${1#*$3}
			if [ -d "$c" ]
			then
				mv -f "$name" $c
			else
				mkdir -p $c
				mv -f "$name" $c
			fi
		fi
	done
}


#el: from   to
funcMVFolder(){

	p=$1
	funcMV $1 $2 $p
}





