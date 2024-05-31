#!/bin/bash

read -p 'Filename seed (ex: unit1) : ' fname
read -p 'Number of pads (recommend multiple of 3): ' otpcount

echo ""
echo "Generating CEOI Communication Electronics Operarating Instructions"

jd=`date +"%j"`
dmode="digital"
otpath="./ceoi-$fname-$jd.txt"
echo "output path: " $otpath

if [ -f "$otpath" ]; then
    rm $otpath
fi

echo " " >> $otpath
echo "Communication Electronic Operating Instructions" >> $otpath
echo "CEOI" >> $otpath
echo "-------------------" >> $otpath
echo " " >> $otpath

#----------------------------
#Emmissions Control"
#---------------------------

echo "Emissions Contol (EmCon)" >> $otpath
echo " " >> $otpath
echo "EMCON 1: Radio Routine." >> $otpath
echo "No perceived threat." >> $otpath
echo " " >> $otpath
echo "EMCON 2: Radio Essential." >> $otpath
echo "Misson-critical/Emergency.  Heightened threat level." >> $otpath
echo "Increased surveillance or potential hostilities." >> $otpath
echo " " >> $otpath
echo "EMCON 3: Radio Silence." >> $otpath
echo "Text and burst data only.  Surveillance present," >> $otpath
echo "Direction finding possible." >> $otpath
echo " " >> $otpath
echo "EMCON 4: Blackout." >> $otpath
echo "Complete silence.  No emissions allowed." >> $otpath
echo "Enemy actively engaging. Risk of detection is high." >> $otpath
echo " " >> $otpath
echo "-------------------" >> $otpath
echo " " >> $otpath
#----------------------------------------
# Frequency generator
#----------------------------------------

echo "Generating Frequencies"

echo "Frequencies      " >> $otpath
echo "If frequency is in use move up" >> $otpath
echo " in 3kHz steps" >> $otpath
#2 Meters
check2m () {
mhz=`shuf -i 146-147 -n 1`
freq=`shuf -i 420-570 -n 1`
}

check2m
while [ $freq -lt 567 -a $freq -gt 505 ] 
do check2m
done
echo "$mhz.$freq FM" >> $otpath

echo "" >> $otpath
echo "Digital frequencies" >> $otpath
echo "-------------------" >> $otpath

#20 Meters Digital
mhz="14"
freq=`shuf -i 025-147 -n 1`
if [ $freq -le 99 ]; then echo "$mhz.0$freq USB $dmode" >> $otpath
else echo "$mhz.$freq USB $dmode - Daylight hours" >> $otpath
fi

#40 Meters Digital
mhz=" 7"
freq=`shuf -i 025-122 -n 1`
if [ $freq -le 99 ]; then echo "$mhz.0$freq USB $dmode - Dawn and Dusk " >> $otpath
else echo "$mhz.$freq USB $dmode - Dawn and Dusk" >> $otpath
fi

#80 Meters Digital
mhz=" 3"
freq=`shuf -i 525-597 -n 1`
if [ $freq -le 99 ]; then echo "$mhz.0$freq USB $dmode" >> $otpath
else echo "$mhz.$freq USB $dmode - Dark hours" >> $otpath
fi
echo "" >> $otpath
echo "SSB/Voice frequencies" >> $otpath
echo "-------------------" >> $otpath

#20 Meters SSB
mhz="14"
freq=`shuf -i 255-347 -n 1`
echo "$mhz.$freq USB Voice - Daylight hours" >> $otpath

#40 Meters SSB
mhz=" 7"
freq=`shuf -i 178-300 -n 1`
echo "$mhz.$freq LSB Voice - Dawn and Dusk" >> $otpath

#80 Meters SSB
mhz=" 3"
freq=`shuf -i 803-999 -n 1`
echo "$mhz.$freq LSB Voice - Dark hours" >> $otpath
echo " " >> $otpath
echo "Alternate 1 = Up 40k + calendar day" >> $otpath
echo "Alternate 2 = Down 35k + calendar  day" >> $otpath
echo " " >> $otpath

#----------------------------------------
# Callsign generator
#----------------------------------------


blocksize=3
blockrow=1
rowcount=9
pagecount=1

echo "-------------------" >> $otpath
echo " " >> $otpath

  echo "Callsign Table" >> $otpath;
echo " "
echo "Generating Callsigns"
echo "# indicates last digit of day" >> $otpath
echo "ex: 2 covers 2, 12, 22" >> $otpath

units=("Alpha" "Bravo" "Charlie" "Delta" "Echo")
count=${#units[@]}

#  echo "             0    1    2    3    4    5    6    7    8    9" >> $otpath;
  echo "" >> $otpath;
chargen () {
        randnum1=`base64 /dev/random | tr -d '+/\r\n0-9a-z' | head -c $blocksize`
        randnum2=`base64 /dev/random | tr -d '+/\r\n0-9a-z' | head -c $blocksize`
        randnum3=`base64 /dev/random | tr -d '+/\r\n0-9a-z' | head -c $blocksize`
        randnum4=`base64 /dev/random | tr -d '+/\r\n0-9a-z' | head -c $blocksize`
        randnum5=`base64 /dev/random | tr -d '+/\r\n0-9a-z' | head -c $blocksize`
        randnum6=`base64 /dev/random | tr -d '+/\r\n0-9a-z' | head -c $blocksize`
        randnum7=`base64 /dev/random | tr -d '+/\r\n0-9a-z' | head -c $blocksize`
        randnum8=`base64 /dev/random | tr -d '+/\r\n0-9a-z' | head -c $blocksize`
        randnum9=`base64 /dev/random | tr -d '+/\r\n0-9a-z' | head -c $blocksize`
        randnum0=`base64 /dev/random | tr -d '+/\r\n0-9a-z' | head -c $blocksize`
}
for ((i=0; i<$count; i++))
do
chargen
echo "  " >> $otpath
echo ${units[i]}" :" >> $otpath;
echo " 0   1   2   3   4" >> $otpath
#  printf %10s "${units[i]} :" >> $otpath;      
       echo -n $randnum1" " >> $otpath;
       echo -n $randnum2" " >> $otpath;
       echo -n $randnum3" " >> $otpath;
       echo -n $randnum4" " >> $otpath;
       echo -n $randnum5" " >> $otpath;
       echo " " >>$otpath
       echo " 5   6   7   8   9" >> $otpath
       echo -n $randnum6" " >> $otpath;
       echo -n $randnum7" " >> $otpath;
       echo -n $randnum8" " >> $otpath;
       echo -n $randnum9" " >> $otpath;
       echo -n $randnum0" " >> $otpath;
       echo "" >> $otpath

done
echo " " >> $otpath
echo " " >> $otpath

#----------------------------------------
# Password generator
#----------------------------------------
echo " "
echo "Generating Passwords"
blocksize=13
rowcount=9

echo " " >> $otpath
echo "-------------------" >> $otpath
echo " " >> $otpath

echo "Passwords" >> $otpath
echo "#'s indicate last digit of day" >> $otpath
echo "ex: 2 covers 2, 12, 22" >> $otpath

  echo "" >> $otpath;
 

for ((i=0; i<=$rowcount; i++))
  do
        randnum1=`base64 /dev/random | tr -dc A-Z0-9 | head -c $blocksize`

echo $i "   "  $randnum1 >> $otpath;
done


#----------------------------------------
# 10 letter Authentication 
#----------------------------------------
echo " "
echo "Generating Word Authentication"
echo " " >> $otpath
echo "-------------------" >> $otpath
echo " " >> $otpath
echo "Authentication Word" >> $otpath;
echo "" >> $otpath
echo "The authentication word is a " >> $otpath
echo "ten-letter word, with no" >> $otpath
echo "duplicate letters. Each letter" >> $otpath
echo "has a corresponding number as" >> $otpath
echo "its value." >> $otpath
word=`shuf -n 1 10-letter-word.file`
totalcode=${#word}
i=0
echo " " >> $otpath
echo "1 2 3 4 5 6 7 8 9 0" >> $otpath
while [ $i -lt $totalcode ]
do
code1=${word:$i:1}
echo -n $code1" " >> $otpath;

((i++))
done
echo " " >> $otpath
echo " " >> $otpath

echo "HOW TO USE IT" >> $otpath
echo " " >> $otpath
echo "1. Ask for a sum. What is " >> $otpath
echo "   the sum of two of the" >> $otpath
echo "   letters." >> $otpath
echo " " >> $otpath
echo "2. Expedient method. What is" >> $otpath
echo "   the fourth letter of the" >> $otpath
echo "   [authentication] word?" >> $otpath
echo " " >> $otpath

#-----------------------------------

#----------------------------------------
# Authentication Table generator
#----------------------------------------

echo " "
echo "Generating Dryad Authentication"
echo " " >> $otpath
echo "-------------------" >> $otpath
echo " " >> $otpath

echo "Dryad Authentication Table       " $jd >> $otpath;
echo "" >> $otpath;
alph="BCDEFGHIJKLMNOPQRSTUVWXYZ"
full=`echo "$alph" | fold -w1 | shuf | tr -d '\n'`
echo "A " ${full:0:4} ${full:4:3} ${full:7:3} ${full:10:2} ${full:12:2} ${full:14:3} ${full:17:2} ${full:19:2} ${full:21:2} ${full:23:2} >> $otpath;

alph="ACDEFGHIJKLMNOPQRSTUVWXYZ"
full=`echo "$alph" | fold -w1 | shuf | tr -d '\n'`
echo "B " ${full:0:4} ${full:4:3} ${full:7:3} ${full:10:2} ${full:12:2} ${full:14:3} ${full:17:2} ${full:19:2} ${full:21:2} ${full:23:2} >> $otpath;

alph="ABDEFGHIJKLMNOPQRSTUVWXYZ"
full=`echo "$alph" | fold -w1 | shuf | tr -d '\n'`
echo "C " ${full:0:4} ${full:4:3} ${full:7:3} ${full:10:2} ${full:12:2} ${full:14:3} ${full:17:2} ${full:19:2} ${full:21:2} ${full:23:2} >> $otpath;

alph="ABCEFGHIJKLMNOPQRSTUVWXYZ"
full=`echo "$alph" | fold -w1 | shuf | tr -d '\n'`
echo "D " ${full:0:4} ${full:4:3} ${full:7:3} ${full:10:2} ${full:12:2} ${full:14:3} ${full:17:2} ${full:19:2} ${full:21:2} ${full:23:2} >> $otpath;

alph="ABCDFGHIJKLMNOPQRSTUVWXYZ"
full=`echo "$alph" | fold -w1 | shuf | tr -d '\n'`
echo "E " ${full:0:4} ${full:4:3} ${full:7:3} ${full:10:2} ${full:12:2} ${full:14:3} ${full:17:2} ${full:19:2} ${full:21:2} ${full:23:2} >> $otpath;

alph="ABCDEGHIJKLMNOPQRSTUVWXYZ"
full=`echo "$alph" | fold -w1 | shuf | tr -d '\n'`
echo "F " ${full:0:4} ${full:4:3} ${full:7:3} ${full:10:2} ${full:12:2} ${full:14:3} ${full:17:2} ${full:19:2} ${full:21:2} ${full:23:2} >> $otpath;

echo "" >> $otpath;
alph="ABCDEFHIJKLMNOPQRSTUVWXYZ"
full=`echo "$alph" | fold -w1 | shuf | tr -d '\n'`
echo "G " ${full:0:4} ${full:4:3} ${full:7:3} ${full:10:2} ${full:12:2} ${full:14:3} ${full:17:2} ${full:19:2} ${full:21:2} ${full:23:2} >> $otpath;

alph="ABCDEFGIJKLMNOPQRSTUVWXYZ"
full=`echo "$alph" | fold -w1 | shuf | tr -d '\n'`
echo "H " ${full:0:4} ${full:4:3} ${full:7:3} ${full:10:2} ${full:12:2} ${full:14:3} ${full:17:2} ${full:19:2} ${full:21:2} ${full:23:2} >> $otpath;

alph="ABCDEFGHJKLMNOPQRSTUVWXYZ"
full=`echo "$alph" | fold -w1 | shuf | tr -d '\n'`
echo "I " ${full:0:4} ${full:4:3} ${full:7:3} ${full:10:2} ${full:12:2} ${full:14:3} ${full:17:2} ${full:19:2} ${full:21:2} ${full:23:2} >> $otpath;

alph="ABCDEFGHIKLMNOPQRSTUVWXYZ"
full=`echo "$alph" | fold -w1 | shuf | tr -d '\n'`
echo "J " ${full:0:4} ${full:4:3} ${full:7:3} ${full:10:2} ${full:12:2} ${full:14:3} ${full:17:2} ${full:19:2} ${full:21:2} ${full:23:2} >> $otpath;

alph="ABCDEFGHIJLMNOPQRSTUVWXYZ"
full=`echo "$alph" | fold -w1 | shuf | tr -d '\n'`
echo "K " ${full:0:4} ${full:4:3} ${full:7:3} ${full:10:2} ${full:12:2} ${full:14:3} ${full:17:2} ${full:19:2} ${full:21:2} ${full:23:2} >> $otpath;

alph="ABCDEFGHIJKMNOPQRSTUVWXYZ"
full=`echo "$alph" | fold -w1 | shuf | tr -d '\n'`
echo "L " ${full:0:4} ${full:4:3} ${full:7:3} ${full:10:2} ${full:12:2} ${full:14:3} ${full:17:2} ${full:19:2} ${full:21:2} ${full:23:2} >> $otpath;

echo "" >> $otpath;
alph="ABCDEFGHIJKLNOPQRSTUVWXYZ"
full=`echo "$alph" | fold -w1 | shuf | tr -d '\n'`
echo "M " ${full:0:4} ${full:4:3} ${full:7:3} ${full:10:2} ${full:12:2} ${full:14:3} ${full:17:2} ${full:19:2} ${full:21:2} ${full:23:2} >> $otpath;

alph="ABCDEFGHIJKLMOPQRSTUVWXYZ"
full=`echo "$alph" | fold -w1 | shuf | tr -d '\n'`
echo "N " ${full:0:4} ${full:4:3} ${full:7:3} ${full:10:2} ${full:12:2} ${full:14:3} ${full:17:2} ${full:19:2} ${full:21:2} ${full:23:2} >> $otpath;

alph="ABCDEFGHIJKLMNPQRSTUVWXYZ"
full=`echo "$alph" | fold -w1 | shuf | tr -d '\n'`
echo "O " ${full:0:4} ${full:4:3} ${full:7:3} ${full:10:2} ${full:12:2} ${full:14:3} ${full:17:2} ${full:19:2} ${full:21:2} ${full:23:2} >> $otpath;

alph="ABCDEFGHIJKLMNOQRSTUVWXYZ"
full=`echo "$alph" | fold -w1 | shuf | tr -d '\n'`
echo "P " ${full:0:4} ${full:4:3} ${full:7:3} ${full:10:2} ${full:12:2} ${full:14:3} ${full:17:2} ${full:19:2} ${full:21:2} ${full:23:2} >> $otpath;

alph="ABCDEFGHIJKLMNOPRSTUVWXYZ"
full=`echo "$alph" | fold -w1 | shuf | tr -d '\n'`
echo "Q " ${full:0:4} ${full:4:3} ${full:7:3} ${full:10:2} ${full:12:2} ${full:14:3} ${full:17:2} ${full:19:2} ${full:21:2} ${full:23:2} >> $otpath;

alph="ABCDEFGHIJKLMNOPQSTUVWXYZ"
full=`echo "$alph" | fold -w1 | shuf | tr -d '\n'`
echo "R " ${full:0:4} ${full:4:3} ${full:7:3} ${full:10:2} ${full:12:2} ${full:14:3} ${full:17:2} ${full:19:2} ${full:21:2} ${full:23:2} >> $otpath;

echo "" >> $otpath;
alph="ABCDEFGHIJKLMNOPQRTUVWXYZ"
full=`echo "$alph" | fold -w1 | shuf | tr -d '\n'`
echo "S " ${full:0:4} ${full:4:3} ${full:7:3} ${full:10:2} ${full:12:2} ${full:14:3} ${full:17:2} ${full:19:2} ${full:21:2} ${full:23:2} >> $otpath;

alph="ABCDEFGHIJKLMNOPQRSUVWXYZ"
full=`echo "$alph" | fold -w1 | shuf | tr -d '\n'`
echo "T " ${full:0:4} ${full:4:3} ${full:7:3} ${full:10:2} ${full:12:2} ${full:14:3} ${full:17:2} ${full:19:2} ${full:21:2} ${full:23:2} >> $otpath;

alph="ABCDEFGHIJKLMNOPQRSTVWXYZ"
full=`echo "$alph" | fold -w1 | shuf | tr -d '\n'`
echo "U " ${full:0:4} ${full:4:3} ${full:7:3} ${full:10:2} ${full:12:2} ${full:14:3} ${full:17:2} ${full:19:2} ${full:21:2} ${full:23:2} >> $otpath;

alph="ABCDEFGHIJKLMNOPQRSTUWXYZ"
full=`echo "$alph" | fold -w1 | shuf | tr -d '\n'`
echo "V " ${full:0:4} ${full:4:3} ${full:7:3} ${full:10:2} ${full:12:2} ${full:14:3} ${full:17:2} ${full:19:2} ${full:21:2} ${full:23:2} >> $otpath;

alph="ABCDEFGHIJKLMNOPQRSTUVXYZ"
full=`echo "$alph" | fold -w1 | shuf | tr -d '\n'`
echo "W " ${full:0:4} ${full:4:3} ${full:7:3} ${full:10:2} ${full:12:2} ${full:14:3} ${full:17:2} ${full:19:2} ${full:21:2} ${full:23:2} >> $otpath;

alph="ABCDEFGHIJKLMNOPQRSTUVWYZ"
full=`echo "$alph" | fold -w1 | shuf | tr -d '\n'`
echo "X " ${full:0:4} ${full:4:3} ${full:7:3} ${full:10:2} ${full:12:2} ${full:14:3} ${full:17:2} ${full:19:2} ${full:21:2} ${full:23:2} >> $otpath;

alph="ABCDEFGHIJKLMNOPQRSTUVWXZ"
full=`echo "$alph" | fold -w1 | shuf | tr -d '\n'`
echo "Y " ${full:0:4} ${full:4:3} ${full:7:3} ${full:10:2} ${full:12:2} ${full:14:3} ${full:17:2} ${full:19:2} ${full:21:2} ${full:23:2} >> $otpath;

alph="ABCDEFGHIJKLMNOPQRSTUVWXY"
full=`echo "$alph" | fold -w1 | shuf | tr -d '\n'`
echo "Z " ${full:0:4} ${full:4:3} ${full:7:3} ${full:10:2} ${full:12:2} ${full:14:3} ${full:17:2} ${full:19:2} ${full:21:2} ${full:23:2} >> $otpath;
echo "" >> $otpath
echo "To request authenticatication" >> $otpath
echo "pick a letter in the left hand column" >> $otpath
echo "pick another letter in that row." >> $otpath
echo "The response is the letter below." >> $otpath
echo "Cross off used codes." >> $otpath
echo "" >> $otpath;


#--------------------------------------------
# Script to generate one time pads
#--------------------------------------------

blocksize=5

blockrow=5

rowcount=14

codeline=1

echo " " >> $otpath
echo "-------------------" >> $otpath
echo " " >> $otpath
echo "One Time Pads" >> $otpath
echo " " >> $otpath
echo " "
echo " "
echo "Generating One Time Pads "
for ((x=1; x<=$otpcount; x++))

do  
  echo " "
  echo $x"/"$otpcount

  for ((i=1; i<=$rowcount; i++))

  do

    for ((j=1; j<=$blockrow; j++))

    do
        echo -n "."
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

if [ $codeline == 1 ]; then echo -n "" >> $otpath; fi
if [ $codeline == 2 ]; then echo -n "" >> $otpath; fi
if [ $codeline == 3 ]; then echo -n "" >> $otpath; fi
if [ $codeline == 4 ]; then echo -n "" >> $otpath; fi
if [ $codeline == 5 ]; then echo -n "" >> $otpath; fi
if [ $codeline == 6 ]; then echo -n "" >> $otpath; fi
if [ $codeline == 7 ]; then echo -n "" >> $otpath; fi
if [ $codeline == 8 ]; then echo -n "" >> $otpath; fi
if [ $codeline == 9 ]; then echo -n "" >> $otpath; fi
if [ $codeline == 10 ]; then echo -n "" >> $otpath; fi
if [ $codeline == 11 ]; then echo -n "" >> $otpath; fi
if [ $codeline == 12 ]; then echo -n "" >> $otpath; fi
      codeline=$((codeline+1))
      echo "" >> $otpath
  done
codeline=1
  echo "" >> $otpath
 
    done

echo "" >> $otpath
echo "-------------------" >> $otpath
echo " " >> $otpath

echo "Conversion Table No.1 (EN)" >> $otpath;
echo "        B-70  P-80  FIG-90" >> $otpath;
echo "   A-1  C-71  Q-81  (.)-91" >> $otpath;
echo "   E-2  D-72  R-82  (:)-92" >> $otpath;
echo "   I-3  F-73  S-83  (')-93" >> $otpath;
echo "   N-4  G-74  U-84  ( )-94" >> $otpath;
echo "   O-5  H-75  V-85  (+)-95" >> $otpath;
echo "   T-6  J-76  W-86  (-)-96" >> $otpath;
echo "        K-77  X-87  (=)-97" >> $otpath;
echo "        L-78  Y-88  REQ-98" >> $otpath;
echo "        M-79  Z-89  SPC-99" >> $otpath;
echo "        Code-0     -E   +D" >> $otpath;
echo "" >> $otpath;
printf '%22s' "(e-d+t/k)" >> $otpath
echo "" >> $otpath;
echo "Encrypt subtract/Decrypt add" >> $otpath;
echo "Text over Key" >> $otpath;
echo "" >> $otpath
echo "------------------------------" >> $otpath
echo "" >> $otpath
echo "Math Table" >> $otpath
echo "Subtract Vertical" >> $otpath
echo "Add Horizontal" >> $otpath
echo "0|0|1|2|3|4|5|6|7|8|9|" >> $otpath
echo "0|0|1|2|3|4|5|6|7|8|9|" >> $otpath
echo "1|9|0|1|2|3|4|5|6|7|8|" >> $otpath
echo "2|8|9|0|1|2|3|4|5|6|7|" >> $otpath
echo "3|7|8|9|0|1|2|3|4|5|6|" >> $otpath
echo "4|6|7|8|9|0|1|2|3|4|5|" >> $otpath
echo "5|5|6|7|8|9|0|1|2|3|4|" >> $otpath
echo "6|4|5|6|7|8|9|0|1|2|3|" >> $otpath
echo "7|3|4|5|6|7|8|9|0|1|2|" >> $otpath
echo "8|2|3|4|5|6|7|8|9|0|1|" >> $otpath
echo "9|1|2|3|4|5|6|7|8|9|0|" >> $otpath
echo "-------------------" >> $otpath
echo " " >> $otpath
echo " "
echo "CEOI file generated -->  " $otpath
