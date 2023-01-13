#
# Remove LF from specified file except CRLF.
# 
#    Assumes a csv record below
# 
#    494,6605,,19027,20191010,,,,,"This is
#    a test",,,,
#
#    First line has LF then second line terminated by CRLF but you want to
#    treat these lines as 1 line CSV record. This script removes LF from first
#    line but leave CRLF on second line.
#
#
#   USAGE:
#
#      $ cat hoge.csv | python rmlf-dos.py
#

import sys

back = 0

for byte in sys.stdin.buffer.read():
    byte = byte.to_bytes(1, 'little')
    if b'\n' != byte or b'\r' == back:
        sys.stdout.buffer.write(byte)

    back = byte
