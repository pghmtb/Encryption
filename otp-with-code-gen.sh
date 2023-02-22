#!/bin/bash

# Script to generate one time pads

read -p 'Filename seed (ex: unit1) : ' fname
read -p 'Number of pads: ' pagecount

blocksize=5

blockrow=5

rowcount=12

codeline=1

jd=`date +"%j"`
otpath="./otp-$fname-$jd.txt"
echo "output path: " $otpath
if test -f "$otpath"; then
    rm $otpath
fi

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

        echo -n " " >> $otpath;

    done 
if [ $codeline == 1 ]; then echo -n "      Conversion Table No.1 (EN)" >> $otpath; fi
if [ $codeline == 2 ]; then echo -n "           B-70  P-80  FIG-90" >> $otpath; fi
if [ $codeline == 3 ]; then echo -n "      A-1  C-71  Q-81  (.)-91" >> $otpath; fi
if [ $codeline == 4 ]; then echo -n "      E-2  D-72  R-82  (:)-92" >> $otpath; fi
if [ $codeline == 5 ]; then echo -n "      I-3  F-73  S-83  (')-93" >> $otpath; fi
if [ $codeline == 6 ]; then echo -n "      N-4  G-74  U-84  ( )-94" >> $otpath; fi
if [ $codeline == 7 ]; then echo -n "      O-5  H-75  V-85  (+)-95" >> $otpath; fi
if [ $codeline == 8 ]; then echo -n "      T-6  J-76  W-86  (-)-96" >> $otpath; fi
if [ $codeline == 9 ]; then echo -n "           K-77  X-87  (=)-97" >> $otpath; fi
if [ $codeline == 10 ]; then echo -n "           L-78  Y-88  REQ-98" >> $otpath; fi
if [ $codeline == 11 ]; then echo -n "           M-79  Z-89  SPC-99" >> $otpath; fi
if [ $codeline == 12 ]; then echo -n "           Code-0     -E   +D" >> $otpath; fi
      codeline=$((codeline+1))
      echo "" >> $otpath;
  done
codeline=1
  echo "" >> $otpath;
  printf '%22s' "(e-d+t/k)" >> $otpath
  echo "" >> $otpath
  echo "------------------------------" >> $otpath
  echo "" >> $otpath

done

exit
