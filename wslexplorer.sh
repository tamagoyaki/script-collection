#!/bin/bash

if [ "$1" == "" ]; then
    echo ""
    echo "USAGE"
    echo ""
    echo "  $ "`basename $0` " path"
    echo ""
    exit -1
fi

echo $1 | grep '/' > /dev/null

# given path is for Linux or not ?
if [ "$?" == "0" ]; then
    opt='-w'
    path=`wslpath $opt $1`
else
    opt=''
    path=$1
fi

#echo $opt '  ' path
explorer.exe $path
