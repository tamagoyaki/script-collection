#!/bin/bash

DIR=wholeearth-workshop
SRC=/home/matsuda/workplace/cho-jyu.jp/jigyou/$DIR/
DST=/mnt/c/Users/matsuda/Google\ Drive/$DIR

EXCLUDE=--exclude=`echo $0 | sed 's/.\///'`
EXCLUDE=$EXCLUDE" "--exclude=*.pptx
EXCLUDE=$EXCLUDE" "--exclude=*.lnk
OPTION=-avz" "$EXCLUDE

if [ "$DRYRUN" == "no" ]; then
    rsync $OPTION $SRC "$DST"
else
    rsync --dry-run $OPTION $SRC "$DST"
    echo
    echo "Do 'DRYRUN=no $0, if everything's OK"
    echo
fi
