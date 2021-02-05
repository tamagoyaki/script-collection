#!/usr/bin/python3

import sys
import csv

USAGE = [
    "",
    "USAGE",
    "",
    "  Set value,  if some cell has specified value.",
    "",
    "  $ ./excelfunc-setvalue-if-equal.py valt valf row rval [rval ... ]",
    "",
    "      valt : value for true",
    "      valf : value for false",
    "      row  : row symbole 'A B C ... ZZ'",
    "      rval : value to set",
    "",
    "",
    "  ex)",
    "      $ ./excelfunc-setvalue-if-equal.py hoge gero B 100 102",
    "      =IF(OR(B1=100, B1=102), \"hoge\", \"gero\")"
    "",
    "",
    "      $ cat source.txt",
    "      14",
    "      32",
    "      34",
    "      43",
    "",
    "      $ ./excelfunc-setvalue-if-equal.py ABC J `cat source.txt`",
    "      =IF(OR(J1=14,J1=32,J1=34,J1=43,J1=44,J1=52,J1=56,J1=58,J1=61,"
    "J1=70), ABC)",
    "",
]

# check commandline options
if 4 > len(sys.argv):
    for row in USAGE:
        print(row)
    exit(-1)

valt = sys.argv[1]
valf = sys.argv[2]
row = sys.argv[3]
func = ""

for cellval in sys.argv[4:]:
    if "" == func:
        func = "=IF(OR("
    else:
        func += ","

    func += row + "1=" + cellval

func += ")"

print(f'{func}, {valt},{valf})')
