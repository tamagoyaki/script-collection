#!/bin/bash
#
#  Copy SDCARD to HDD with name
#
#    Thechnically, copy something to somewhere, regardless SDCARD and HDD.
#
#  NOTE:
#
#      There is no eject command on Windows. so you have to eject SDCARD
#      manually.
#
#  USAGE:
#
#      # ./sd2hdd
#
#      Thank for Windows weird behavior, there is trick you have to do.
#
#        1, Insert SDCARD
#        2, Wait for notification of windows (or auto open explorer maybe)
#        3, do sd2hdd as root
#        4, follow the instructions this script shows.
#
#        Thru the operation, Don't open the drive that SDCARD is mounted by
#        explorer or you can't umount the drive.
#



# Source and distination
SD=/mnt/e
HDD=/mnt/f


# Eject and Insert SDCARD don't affect wsl mount points. How weired :-(
mount -t drvfs e: $SD

# SDCARD has been marked ?
PREFIX=CAM

ls $SD/$PREFIX* > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "The SDCARD is already marked. confirm and delete it then retry!!"
    umount $SD
    exit
fi

# Create a mark by cam number you input
read -p "Destination folder name : " name
MARK=$PREFIX$name

# HDD has the same cam number ?
ls $HDD/$name > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "The HDD has the same camera number."
    umount $SD
    exit
fi

# engrabe the mark on SDCARD
touch $SD/$MARK

# copy whole data to HDD
# DRYRUN=--dry-run
EXCLUDE=--exclude="System*"
rsync $DRYRUN $EXCLUDE -rlOocDvz --ignore-existing --progress $SD/* $HDD/$name

# wait to eject SDCARD then umount
sync
umount $SD
echo ''
echo 'Do following instructions.'
echo ''
echo '  Eject SDCARD manually and wait ejected safelly'
echo ''
echo ''

