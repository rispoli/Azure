#!/bin/bash

echo 'Read IOPS (k):'
grep '  read:' $1 | sed -e 's/IOPS=//' -e 's/k,//' -e 's/BW=//' -e 's#MiB/s.*##' | dbuck -s -S -a -b -k1
echo -e '\nRead bandwidth (MiB/s):'
grep '  read:' $1 | sed -e 's/IOPS=//' -e 's/k,//' -e 's/BW=//' -e 's#MiB/s.*##' | dbuck -s -S -a -b -k2

echo -e '\nWrite IOPS (k):'
grep '  write:' $1 | sed -e 's/IOPS=//' -e 's/k,//' -e 's/BW=//' -e 's#MiB/s.*##' | dbuck -s -S -a -b -k1
echo -e '\nWrite bandwidth (MiB/s):'
grep '  write:' $1 | sed -e 's/IOPS=//' -e 's/k,//' -e 's/BW=//' -e 's#MiB/s.*##' | dbuck -s -S -a -b -k2
