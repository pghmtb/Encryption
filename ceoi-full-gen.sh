#!/bin/bash

read -p 'Filename seed (ex: unit1) : ' fname
read -p 'Number of one time pads to generate: ' otpcount

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

#--------------------------------------
#2m Simplex for close range
#--------------------------------------
echo "2m Simplex frequencies" >> $otpath
echo " " >> $otpath
# Function to generate a random frequency within a specific range
generate_random_frequency_in_range() {
    local start_frequency=$1
    local end_frequency=$2

    # Generate a random frequency within the range
    random_frequency=$(awk -v min="$start_frequency" -v max="$end_frequency" \
        'BEGIN{srand(); printf "%.2f\n", min+rand()*(max-min)}')

    # Return the random frequency
    echo "$random_frequency"
}

# Function to randomly select three non-duplicate frequencies
select_three_non_duplicate_frequencies() {
    local range1_start=$1
    local range1_end=$2
    local range2_start=$3
    local range2_end=$4
    local frequency1 frequency2 frequency3

    # Generate the first random frequency within the first range
    frequency1=$(generate_random_frequency_in_range $range1_start $range1_end)

    # Generate the second random frequency within the second range, ensuring it's different from the first
    while :; do
        frequency2=$(generate_random_frequency_in_range $range2_start $range2_end)
        if [ "$frequency2" != "$frequency1" ]; then
            break
        fi
    done

    # Generate the third random frequency within the second range, ensuring it's different from the first two
    while :; do
        frequency3=$(generate_random_frequency_in_range $range2_start $range2_end)
        if [ "$frequency3" != "$frequency1" ] && [ "$frequency3" != "$frequency2" ]; then
            break
        fi
    done

    # Output the selected frequencies
    echo "Primary: $frequency1 MHz" >> $otpath
    echo "Alternate: $frequency2 MHz" >> $otpath
}

# Define the frequency ranges
range1_start=146.40
range1_end=146.58
range2_start=147.42
range2_end=147.57

# Select three non-duplicate frequencies within the defined ranges
select_three_non_duplicate_frequencies $range1_start $range1_end $range2_start $range2_end

echo " " >> $otpath
echo "-------------------" >> $otpath
echo " " >> $otpath



#---------------------------------------
#Communications Windows
#---------------------------------------
echo "Generating Communicaations Windows"
echo "Communications Windows" >> $otpath
echo " " >> $otpath
#!/bin/bash

# Function to generate a random frequency within a given range
generate_frequency() {
    lower=$1
    upper=$2
    printf "%.3f\n" $(echo "scale=3; $lower + ($upper - $lower) * $RANDOM / 32767" | bc)
}
echo " " >> $otpath
# Function to generate a communication plan for a specific time range
generate_plan() {
    start_time=$1
    end_time=$2
    lower_freq=$3
    upper_freq=$4

    for ((i=1; i<=1; i++)); do
        freq=$(generate_frequency $lower_freq $upper_freq)
        echo $start_time "  Frequency: $freq MHz" >> $otpath
    done
}

# Generate communication plans for each time range
generate_plan "0300z-0900z" "3.803-3.997" 3.803 3.997
generate_plan "0900z-1400z" "7.178-7.297" 7.178 7.297
generate_plan "1400z-2300z" "14.228-14.347" 14.228 14.347
generate_plan "2300z-0300z" "7.178-7.297" 7.178 7.297

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
echo "Use to secure files/drives" >> $otpath
echo "#'s indicate last digit of day" >> $otpath
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
echo "To request authentication" >> $otpath
echo "pick a letter in the left hand column" >> $otpath
echo "pick another letter in that row." >> $otpath
echo "The response is the letter below." >> $otpath
echo "Cross off used codes." >> $otpath
echo "" >> $otpath;


#--------------------------------------------
# Script to generate one time pads
#--------------------------------------------
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

# Function to generate a random 5-digit group
generate_random_group() {
    printf "%05d\n" $((RANDOM % 100000))
}

# Generate the one-time pad
generate_one_time_pad() {
    for ((row=0; row<5; row++)); do
        for ((group=0; group<5; group++)); do
            generate_random_group
        done | paste -sd " " - >> $otpath
    done
}

# Output the one-time pad

generate_one_time_pad
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
