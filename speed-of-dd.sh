#!/bin/bash
#
# https://serverfault.com/questions/147935/how-to-determine-the-best-byte-size-for-the-dd-command/148121#148121
#
# https://qiita.com/wf9a5m75/items/6bfea7a2b8c9658ce4fc
#

echo "creating a file to work with"
dd if=/dev/zero of=/var/tmp/infile count=1175000

for bs in  1k 2k 4k 8k 16k 32k 64k 128k 256k 512k 1M 2M 4M 8M 16M 32M 64M 128M 256M 512M

do
        echo "---------------------------------------"
        echo "Testing block size  = $bs"
        dd if=/var/tmp/infile of=/var/tmp/outfile bs=$bs
        echo ""
done
rm /var/tmp/infile /var/tmp/outfile
