#!/bin/bash

blocksize=5
blockrow=5
rowcount=10
pagecount=10
otpath='./notp.txt'
bookserial=`sudo base64 /dev/hwrng | tr -dc '0-9'| head -c 5`

rm $otpath
for ((x=1; x<=$pagecount; x++))
do  
  echo -n $bookserial >> $otpath;
  printf '%22s' $x"/"$pagecount >> $otpath;
  echo "" >> $otpath;
  for ((i=1; i<=$rowcount; i++))
  do
    for ((j=1; j<=$blockrow; j++))
    do
        randnum=`sudo base64 /dev/hwrng | tr -dc '0-9'| head -c $blocksize`
        echo -n $randnum >> $otpath;
        echo -n "  " >> $otpath;
    done
      echo "" >> $otpath;
  done
  echo "--------------------------------" >> $otpath
done
