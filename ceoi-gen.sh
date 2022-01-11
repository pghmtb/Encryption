#!/bin/bash

read -p 'Filename seed (ex: unit1) : ' fname


echo ""
echo "Generating CEOI Communication"
echo " Electronics Operarating"
echo " Instructions"
echo ""

#----------------------------------------
# Frequency generator
#----------------------------------------

echo "Generating Frequencies"

jd=`date +"%j"`
dmode="cont-4/250 ctr 1500"
otpath='./freq.tmp'
if [ -f "$otpath" ]; then
    rm $otpath
fi

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

#10 Meters digital
mhz="28"
freq=`shuf -i 000-297 -n 1`
if [ $freq -le 99 ]; then echo "$mhz.0$freq USB $dmode" >> $otpath
else echo "$mhz.$freq USB $dmode" >> $otpath
fi

#20 Meters Digital
mhz="14"
freq=`shuf -i 025-147 -n 1`
if [ $freq -le 99 ]; then echo "$mhz.0$freq USB $dmode" >> $otpath
else echo "$mhz.$freq USB $dmode" >> $otpath
fi

#40 Meters Digital
mhz=" 7"
freq=`shuf -i 025-122 -n 1`
if [ $freq -le 99 ]; then echo "$mhz.0$freq USB $dmode" >> $otpath
else echo "$mhz.$freq USB $dmode" >> $otpath
fi

#80 Meters Digital
mhz=" 3"
freq=`shuf -i 525-597 -n 1`
if [ $freq -le 99 ]; then echo "$mhz.0$freq USB $dmode" >> $otpath
else echo "$mhz.$freq USB $dmode" >> $otpath
fi
echo "" >> $otpath
echo "SSB/Voice frequencies" >> $otpath
echo "-------------------" >> $otpath

#10 meters SSB
mhz=`shuf -i 28-29 -n 1`
if [ $mhz -eq 28 ]
then freq=`shuf -i 300-999 -n 1`
else
freq=`shuf -i 000-697 -n 1`
fi
echo "$mhz.$freq USB" >> $otpath


#20 Meters SSB
mhz="14"
freq=`shuf -i 255-347 -n 1`
echo "$mhz.$freq USB" >> $otpath

#40 Meters SSB
mhz=" 7"
freq=`shuf -i 178-300 -n 1`
echo "$mhz.$freq LSB" >> $otpath

#80 Meters SSB
mhz=" 3"
freq=`shuf -i 803-999 -n 1`
echo "$mhz.$freq LSB" >> $otpath

#----------------------------------------
# Callsign generator
#----------------------------------------


blocksize=3
blockrow=1
rowcount=9
pagecount=1
otpath='./callsign.tmp'


if [ -f "$otpath" ] ; then
    rm $otpath
fi

  echo "Callsign Table" >> $otpath;
echo "Generating Callsigns.."
echo "# indicates last digit of day" >> $otpath
echo "ex: 2 covers 2, 12, 22" >> $otpath
echo "" >> $otpath

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
echo ${units[i]}" :" >> $otpath;
echo " 0   1   2   3   4   5" >> $otpath
#  printf %10s "${units[i]} :" >> $otpath;      
       echo -n $randnum1" " >> $otpath;
       echo -n $randnum2" " >> $otpath;
       echo -n $randnum3 " ">> $otpath;
       echo -n $randnum4" " >> $otpath;
       echo -n $randnum5" " >> $otpath;
       echo " " >>$otpath
       echo " 6   7   8   9" >> $otpath
       echo -n $randnum6" " >> $otpath;
       echo -n $randnum7" " >> $otpath;
       echo -n $randnum8" " >> $otpath;
       echo -n $randnum9" " >> $otpath;
       echo -n $randnum0" " >> $otpath;
       echo "" >> $otpath
       echo "-----------------------------" >> $otpath;
done


#----------------------------------------
# Password generator
#----------------------------------------
echo "Generating Passwords"
blocksize=13
rowcount=9
otpath='./pass.tmp'


if [ -f "$otpath" ]; then
    rm $otpath
fi
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
echo "Generating Authentication"
jd=`date +"%j"`
otpath='./auth.tmp'
if [ -f "$otpath" ]; then
    rm $otpath
fi

echo "Authentication Word" >> $otpath;
echo "" >> $otpath
echo "The authentication word is a " >> $otpath
echo "ten-letter word, with no" >> $otpath
echo "duplicate letters. Each letter" >> $otpath
echo "has a corresponding number as" >> $otpath
echo "its value." >> $otpath
echo ""
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
#-----------------------------------
#Gen file
#-----------------------------------
#-----------------------------------
#fname=`base64 /dev/random | tr -dc a-z0-9 | head -c 6`
otpath="./ceoi-$fname-$jd.txt"


if [ -f "$otpath" ]; then
    rm $otpath
fi

echo "Creating $otpath"
echo "" >> $otpath
echo "CEOI-$fname-$jd" >> $otpath
echo "" >> $otpath
#-----------------------------------

echo "------------------------------" >> $otpath
echo"" >> $otpath
cat ./freq.tmp >> $otpath
echo "" >> $otpath
echo "------------------------------" >> $otpath
echo"" >> $otpath
cat ./callsign.tmp >> $otpath
echo "" >> $otpath
echo "------------------------------" >> $otpath
echo"" >> $otpath
cat ./pass.tmp >> $otpath
echo "" >> $otpath
echo "------------------------------" >> $otpath
echo"" >> $otpath
cat ./auth.tmp >> $otpath
echo "" >> $otpath
echo "------------------------------" >> $otpath
echo "" >>$otpath
echo ""
echo "Cleaning up"
rm ./freq.tmp
rm ./callsign.tmp
rm ./pass.tmp
rm ./auth.tmp
echo ""
echo "finished"


 
