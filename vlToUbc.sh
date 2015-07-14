#!/bin/bash

# Author: Bin Xiang

sift_file=$1
key_file=`echo $sift_file | sed 's/sift$/key/'`
keynum=`wc -l $sift_file | egrep -o "^[0-9]{1,}"`
echo "find $keynum keys"
echo "$keynum 128" > $key_file
awk -F ' ' '{tmp=$1;$1=$2;$2=tmp;$4=$4"\n";for(i=24;i<132;i+=20){$i=$i"\n"}}1' $sift_file >> $key_file
