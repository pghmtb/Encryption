#!/bin/bash

jd=`date +"%j"`
fname=`base64 /dev/random | tr -dc a-z0-9 | head -c 6`
otpath="./codebook-$fname-$jd.txt"
if [ -f "$otpath" ]; then
    rm $otpath
fi
echo ""
echo "Generating $otpath - please wait"
echo ""

words=(
 "Abort"
 "Address"
 "Affirmative"
 "Aircraft fixed wing Qty"
 "Aircraft large unmanned Qty"
 "Aircraft rotary winged Qty"
 "Aircraft small unmanned Qty"
 "Ammo"
 "Armed Men Qty"
 "Attack"
 "Barn or Shed"
 "Bearing Magnetic compass bearing"
 "Bearing true compass bearing"
 "Boat or Ship Qty"
 "Border"
 "Building"
 "Car Qty"
 "Cave"
 "Checkpoint"
 "Civilian Qty"
 "Clearing"
 "Compromise"
 "Computer"
 "Coordinate"
 "Creek"
 "Danger"
 "Distance in meters"
 "Do Not Answer"
 "Dog"
 "Door"
 "East"
 "Execute"
 "Farm"
 "Fence"
 "Figures Use 99 to end"
 "Forward this message to:"
 "Frequency "
 "Friendly"
 "Gate"
 "Grid"
 "Harbor"
 "Hill"
 "Home Base"
 "I see"
 "Immediate"
 "Impossible"
 "Instruction"
 "Light Armor Qty"
 "Livestock"
 "Location"
 "Medevac"
 "Message Readibility 1 to 5"
 "Mountain"
 "Moving Away From"
 "Moving Towards"
 "My Location"
 "Negative"
 "North"
 "North East"
 "North West"
 "Observe ed"
 "Possible"
 "Priority"
 "Probable"
 "Radio"
 "Rally"
 "Range"
 "Remain in place"
 "River"
 "Road"
 "Sattellite Dish"
 "Signal Strength 1 to 9"
 "Soldiers Qty"
 "South"
 "South East"
 "South West"
 "Street"
 "Tanks Qty"
 "Telephone"
 "Time"
 "Train"
 "Train Tracks"
 "Transmit"
 "Travel"
 "Truck Qty"
 "Unknown"
 "Unseen"
 "Valley"
 "We Are"
)

count=${#words[@]}



aacode=(`base64 /dev/random | tr -d '+/\r\n0-9a-z' | head -c 3`)
for ((i=1; i<$count; i++))
do
aacode+=(`base64 /dev/random | tr -d '+/\r\n0-9a-z' | head -c 3`)
done

IFS=$'\n' sorted=($(sort <<<"${aacode[*]}")); unset IFS
sualpha=($(echo "${sorted[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' '))
echo "" >> $otpath
echo "Codebook-$fname-$jd" >> $otpath
echo "---------------------------------" >> $otpath
echo "" >> $otpath
echo "QTY in 2 digits if more than 99, 3 digits with" >> $otpath
echo "the first two being "00" followed by how many hundred." >> $otpath

base=`sudo base64 /dev/hwrng | tr -dc '0-3'| head -c 3`

getcode () {
acode=`base64 /dev/random | tr -d '+/\r\n0-9a-z' | head -c 3`
ncode=`sudo base64 /dev/hwrng | tr -dc '0-9'| head -c 1`
num=$((base + ncode))
base=$((num))
}



echo "" >> $otpath
echo "Code book    " $jd >> $otpath
echo "" >> $otpath
echo "Alpha code can be used for plain text, CW and PTE encryption" >> $otpath
echo "Numeric codes for OTP only" >> $otpath
echo "" >> $otpath
echo "OPCODE NUM Code Term(s) Data to Follow" >> $otpath
echo "" >> $otpath
for ((i=0; i<$count; i++))
do
getcode
echo ${sualpha[i]} $num ${words[i]} >> $otpath
done

echo "Finished ----> $otpath"

