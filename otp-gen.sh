#!/bin/bash

# Script to generate one time pads


if [ -z "$1" ]; then echo  "Usage: ./otp-gen.sh <filename> <nuber of pads to generate> "; exit; fi
fname=$1
pagecount=$2

blocksize=5

blockrow=5

rowcount=10

jd=`date +"%j"`
otpath="./otp-$fname-$jd.txt"
echo "output path: " $otpath

rm $otpath
echo "" >> $otpath
echo "" >> $otpath

for ((x=1; x<=$pagecount; x++))

do  
  echo $x"/"$pagecount

  for ((i=1; i<=$rowcount; i++))

  do

    for ((j=1; j<=$blockrow; j++))

    do

        randnum=`sudo base64 /dev/hwrng | tr -dc '0-9'| head -c $blocksize`
       if  [ $i == 1 ] && [ $j == 1 ]
       then echo -n $randnum >> $otpath;
       #printf '%22s' $x"/"$pagecount >> $otpath;
       echo "" >> $otpath;
       echo "" >> $otpath;
       fi

        echo -n $randnum >> $otpath;

        echo -n "  " >> $otpath;

    done 

      echo "" >> $otpath;
  done
  echo "" >> $otpath;
  printf '%22s' "(e-d+t/k)" >> $otpath
  echo "" >> $otpath
  echo "" >> $otpath
  echo "--------------------------------" >> $otpath
  echo "" >> $otpath

done



echo "Conversion Table No.1 (EN)">> $otpath

echo "     B-70  P-80  FIG-90">> $otpath

echo "A-1  C-71  Q-81  (.)-91">> $otpath

echo "E-2  D-72  R-82  (:)-92">> $otpath

echo "I-3  F-73  S-83  (')-93">> $otpath

echo "N-4  G-74  U-84  ( )-94">> $otpath

echo "O-5  H-75  V-85  (+)-95">> $otpath

echo "T-6  J-76  W-86  (-)-96">> $otpath

echo "     K-77  X-87  (=)-97">> $otpath

echo "     L-78  Y-88  REQ-88">> $otpath

echo "     M-79  Z-89  SPC-99">> $otpath

echo "Code-0     -E   +D">> $otpath

exit
