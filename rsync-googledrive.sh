#!/bin/bash

DIR=wholeearth-workshop
SRC=/home/matsuda/workplace/cho-jyu.jp/jigyou/$DIR/
DST=/mnt/c/Users/matsuda/Google\ Drive/$DIR

EXCLUDE=--exclude=`echo $0 | sed 's/.\///'`
EXCLUDE=$EXCLUDE" "--exclude=*.pptx
EXCLUDE=$EXCLUDE" "--exclude=*.lnk
EXCLUDE=$EXCLUDE" "--exclude=qgis
OPTION=-avz" "--delete" "$EXCLUDE

DATE=`date +%Y%m%d%H%M%S`
LOGFILE=--log-file=$DATE.log


if [ "$DRYRUN" == "no" ]; then
    rsync $LOGFILE $OPTION $SRC "$DST"
else
    rsync --dry-run $LOGFILE $OPTION $SRC "$DST"
    echo
    echo "Do 'DRYRUN=no $0, if everything's OK"
    echo
fi
