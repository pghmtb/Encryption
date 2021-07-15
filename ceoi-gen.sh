#!/bin/bash

read -p 'Filename seed (ex: unit1) : ' fname
read -p 'Number of codes: ' otppagecount


echo ""
echo "Generating CEOI Communication Electronics Operarating Instructions"
echo ""

#----------------------------------------
# Frequency generator
#----------------------------------------

echo "Generating Frequencies"

jd=`date +"%j"`
dmode="MFSK-32 ctr 1500"
otpath='./freq.txt'
if [ -f "$otpath" ]; then
    rm $otpath
fi

echo "Frequencies      " $jd >> $otpath
echo "If frequency is in use move up in 3kHz steps" >> $otpath
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
otpath='./callsign.txt'


if [ -f "$otpath" ] ; then
    rm $otpath
fi

  echo "Callsign Table" >> $otpath;
echo "Generating Callsigns - please wait..."
echo "Numbers indicate last digit of day" >> $otpath
echo "ex: 2 covers 2, 12, 22" >> $otpath
echo "" >> $otpath

units=("Alpha" "Bravo" "Charlie" "Delta" "Echo")
count=${#units[@]}

  echo "             0    1    2    3    4    5    6    7    8    9" >> $otpath;
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
  printf %10s "${units[i]} :" >> $otpath;      
       echo -n " " $randnum1 >> $otpath;
       echo -n " " $randnum2 >> $otpath;
       echo -n " " $randnum3 >> $otpath;
       echo -n " " $randnum4 >> $otpath;
       echo -n " " $randnum5 >> $otpath;
       echo -n " " $randnum6 >> $otpath;
       echo -n " " $randnum7 >> $otpath;
       echo -n " " $randnum8 >> $otpath;
       echo -n " " $randnum9 >> $otpath;
       echo -n " " $randnum0 >> $otpath;
      echo "" >> $otpath;
done


#----------------------------------------
# Password generator
#----------------------------------------
echo "Generating Passwords - please wait..."
blocksize=13
rowcount=9
otpath='./pass.txt'


if [ -f "$otpath" ]; then
    rm $otpath
fi
echo "Passwords" >> $otpath
echo "Numbers indicate last digit of day" >> $otpath
echo "ex: 2 covers 2, 12, 22" >> $otpath

  echo "" >> $otpath;
 

for ((i=0; i<=$rowcount; i++))
  do
        randnum1=`base64 /dev/random | tr -dc A-Z0-9 | head -c $blocksize`

echo $i "   "  $randnum1 >> $otpath;
done


#----------------------------------------
# Authentication Table generator
#----------------------------------------
echo "Generating Authentication - please wait..."
jd=`date +"%j"`
otpath='./auth.txt'
if [ -f "$otpath" ]; then
    rm $otpath
fi

echo "Authentication Table          " >> $otpath;
echo "" >> $otpath
echo "The alphabet is listed in a column on the left." >> $otpath
echo "Across the top are the numbers 0-9, and the alphabet," >> $otpath
echo "split into groups of 2-4 letters." >> $otpath
echo "To authenticate, the person requesting authentication" >> $otpath
echo "picks a letter in the left hand column, and then" >> $otpath
echo "picks a random letter from the alphabet (which will be in the row.)" >> $otpath
echo "The responder will find the corresponding letter on their " >> $otpath
echo "copy of the table, and respond with the letter below the one chosen." >> $otpath
echo "For example:" >> $otpath
echo "Bravo One, This is Bravo Six... Authenticate Delta Victor, Over" >> $otpath
echo "We go down to row “D”, and then go across to the letter V." >> $otpath
echo "We check that the letter immediately under is the letter K" >> $otpath
echo "so Bravo One would respond Bravo Six, This is Bravo One... I Authenticate Kilo, Over." >> $otpath
echo "It is important that both parties mark authenticators once they have been used," >> $otpath
echo "so they are not re-used." >> $otpath
echo "" >> $otpath;
echo "Authentication Table          " $jd >> $otpath;
echo "" >> $otpath;
echo "   ABC  DEF GHJ KL MN PQR ST UV WX YZ" >> $otpath;
echo "    0    1   2  3  4   5  6  7  8  9" >> $otpath;
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
echo "   ABC  DEF GHJ KL MN PQR ST UV WX YZ" >> $otpath;
echo "    0    1   2  3  4   5  6  7  8  9" >> $otpath;
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
echo "   ABC  DEF GHJ KL MN PQR ST UV WX YZ" >> $otpath;
echo "    0    1   2  3  4   5  6  7  8  9" >> $otpath;
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
echo "   ABC  DEF GHJ KL MN PQR ST UV WX YZ" >> $otpath;
echo "    0    1   2  3  4   5  6  7  8  9" >> $otpath;
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



#----------------------------------------
# One Time Pad generator
#----------------------------------------
echo "Generating OTP - please wait..."
blocksize=5
blockrow=5
rowcount=10
#pagecount=3

otpath='./otp.txt'
#bookserial=`sudo base64 /dev/hwrng | tr -dc '0-9'| head -c 5`

if [ -f "$otpath" ]; then
    rm $otpath
fi
echo "One time Pad" >> $otpath
echo "Example.  Use the Conversion table to get the plain code then subtract the OTP key:" >> $otpath
echo "If the top number is less than the OTP key number, you just add 10 to the top number" >> $otpath
echo "" >> $otpath
echo "M  E E T I N G     A T    1   4      P  M     I N    N Y  (.)" >> $otpath
echo "79 2 2 6 3 4 74 99 1 6 90 111 444 90 80 79 99 3 4 99 4 88 91" >> $otpath
echo "Plaincode : KEYID 79226 34749 91690 11144 49080 79993 49948 89191" >> $otpath
echo "OTP Key(-): 68496 47757 10126 36660 25066 07418 79781 48209 28600" >> $otpath
echo "-----------------------------------------------------" >> $otpath
echo "Ciphertext: 68496 32579 24623 65030 96188 42672 00212 01749 61591" >> $otpath
echo "" >> $otpath
echo "Numbers are written between 90, before and after and the individual numbers" >> $otpath
echo "are repeated 3 Times." >> $otpath
echo "" >> $otpath
echo "To decode you just add the Ciphertext to the OTP Key(+)." >> $otpath
echo "If the result is greater than 10, just subtract 10." >> $otpath
echo "" >> $otpath;

for ((x=1; x<=$otppagecount; x++))
do  
  bookserial=`sudo base64 /dev/hwrng | tr -dc '0-9'| head -c 5`
  echo -n $bookserial >> $otpath;
  printf '%22s' $x"/"$otppagecount >> $otpath;
  printf '%22s' $x"/"$otppagecount
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
echo "" >> $otpath;
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

echo ""
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
# PACE
#----------------------------------
echo "----------------------------------------" >> $otpath
echo "P.A.C.E for Comms" >> $otpath
echo "Primary 	Email" >> $otpath
echo "Alternate	txt" >> $otpath
echo "Contingency	Radio" >> $otpath
echo "Emergency 	Person to person or hard drop" >> $otpath
echo "" >> $otpath
echo "P.A.C.E for Encryption" >> $otpath
echo "Primary		PTE/SSE		Multi platform java based https://paranoiaworks.mobi/" >> $otpath
echo "Alternate	OTP		One Time Pad" >> $otpath
echo "Contingency	Codebook	Codebook to obscure message" >> $otpath
echo "Emergency	Auth table	Can be use to encode message" >> $otpath
echo "" >> $otpath
echo "----------------------------------------" >> $otpath
echo"" >> $otpath
cat ./freq.txt >> $otpath
echo "" >> $otpath
echo "----------------------------------------" >> $otpath
echo"" >> $otpath
cat ./callsign.txt >> $otpath
echo "" >> $otpath
echo "----------------------------------------" >> $otpath
echo"" >> $otpath
cat ./pass.txt >> $otpath
echo "" >> $otpath
echo "----------------------------------------" >> $otpath
echo"" >> $otpath
cat ./auth.txt >> $otpath
echo "" >> $otpath
echo "----------------------------------------" >> $otpath
echo"" >> $otpath
cat ./otp.txt >> $otpath
echo ""
echo "Cleaning up"
rm ./freq.txt
rm ./callsign.txt
rm ./pass.txt
rm ./auth.txt
rm ./otp.txt
echo ""
echo "finished"


 
