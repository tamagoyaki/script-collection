#!/bin/bash

BS0=/tokyo/minato
BS1=/osaka/nanba
BS2=/fukuoka/tenjin

# backup source and destination
SRC="$BS0 $BS1 $BS2"
DST=/mnt/d/rsync-backup

# you may want to change rsync options
OPTION=-rlOocDvz



#
# below are script body (leave intact)
#
DATE=`date +%Y%m%d%H%M%S`
LOGFILE=--log-file=$DATE"-rsync-backup.log"

function check_root () {
    if [ $UID -eq 0 ]; then
	ans="y"
    else
	read -n1 -p "You aren't root. continue anyway ? [y/n ]" ans
    fi

    echo ""

    if [ $ans == "n" ]; then
	exit -1
    fi
}

function confirmation () {
    if [ "$DRYRUN" == "no" ]; then
	echo "gonna backup by DRYRUN=$DRYRUN"
    elif [ "$DRYRUN" == "yes" ]; then
	echo "gonna dryrun by DRYRUN=$DRYRUN"
    fi

    if [ "$POWEROFF" == "yes" ]; then
	echo "gonna poweroff by POWEROFF=$POWEROFF"
    fi

    read -n1 -p "are you sure ? [y/n ]" ans
    echo ""

    if [ $ans == "n" ]; then
	exit -1
    fi
}

if [ "$DRYRUN" == "no" ]; then
    confirmation
    check_root
    rsync $LOGFILE $OPTION $SRC "$DST"
elif [ "$DRYRUN" == "yes" ]; then
    confirmation
    check_root
    rsync --dry-run $LOGFILE $OPTION $SRC "$DST"
else
    echo
    echo "USAGE"
    echo
    echo "  You must be root."
    echo
    echo "  DRYRUN=yes $0             -  see what will happens."
    echo "  DRYRUN=no $0,             -  do backup"
    echo "  DRYRUN=no POWEROFF=yes $0 -  poweroff after backup completed."
    echo
    echo "EXAMPLE"
    echo
    echo "  DRYRUN=yes $0 | tee backup.log"
    echo "  DRYRUN=no $0"
    echo "  DRYRUN=no POWEROFF=yes $0"
    echo "  (time DRYRUN=no $0) 2>&1 | tee LOG "
    echo
    exit -1
fi

if [ "$POWEROFF" == "yes" ]; then
    # wsl or linux ?
    grep -q -i microsoft /proc/version

    if [ 0 == $? ]; then
	/mnt/c/Windows/system32/shutdown.exe /s /f /t 30
    else
	poweroff
    fi
fi
