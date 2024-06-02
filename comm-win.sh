#!/bin/bash

read -p 'Filename seed (ex: unit1) : ' fname

echo ""

jd=`date +"%j"`
dmode="digital"
otpath="./comm-win-$fname-$jd.txt"
echo "output path: " $otpath

if [ -f "$otpath" ]; then
    rm $otpath
fi

echo " " >> $otpath

#---------------------------------------
#Communications Windows
#---------------------------------------
echo "Generating Communicaations Windows"
echo "Communications Window and Frequency" >> $otpath
echo " " >> $otpath

# Function to generate a random time within a specific range in UTC format
generate_random_time_in_range() {
    local start_hour=$1
    local start_minute=$2
    local end_hour=$3
    local end_minute=$4

    # Calculate the total minutes from the start of the day for the start and end times
    start_total_minutes=$((start_hour * 60 + start_minute))
    end_total_minutes=$((end_hour * 60 + end_minute))

    if [ $end_total_minutes -gt $start_total_minutes ]; then
        # If the end time is later in the same day
        total_minutes_range=$((end_total_minutes - start_total_minutes))
    else
        # If the end time is on the next day
        total_minutes_range=$((end_total_minutes + 1440 - start_total_minutes))
    fi

    # Pick a random minute offset within the range
    random_offset=$((RANDOM % total_minutes_range))
    total_minutes=$((start_total_minutes + random_offset))

    # Calculate the resulting hour and minute
    hour=$((total_minutes / 60 % 24))
    minute=$((total_minutes % 60))
    second=0

    # Format and return the time in UTC format
    printf "%02d:%02d:%02dZ\n" $hour $minute $second
}

# Function to generate a random frequency within a specific range
generate_random_frequency_in_range() {
    local start_frequency=$1
    local end_frequency=$2

    # Generate a random frequency within the range
    random_frequency=$(awk -v min="$start_frequency" -v max="$end_frequency" \
        'BEGIN{srand(); printf "%.3f\n", min+rand()*(max-min)}')

    # Return the random frequency
    echo "$random_frequency MHz"
}

# Function to generate communication windows for voice and digital
generate_communication_windows() {
    local voice_start_hour=$1
    local voice_end_hour=$2
    local voice_start_frequency=$3
    local voice_end_frequency=$4
    local digital_start_frequency=$5
    local digital_end_frequency=$6

    # Generate a random 15-minute window for voice communication
    voice_start_time=$(generate_random_time_in_range $voice_start_hour 0 $voice_end_hour 45)
    voice_end_time=$(date -u -d"$voice_start_time +15 minutes" +%H:%M:%SZ)
    voice_frequency=$(generate_random_frequency_in_range $voice_start_frequency $voice_end_frequency)

    # Generate a random 15-minute window for digital communication starting right after the voice window
    digital_start_time=$(date -u -d"$voice_end_time +1 minute" +%H:%M:%SZ)
    digital_end_time=$(date -u -d"$digital_start_time +15 minutes" +%H:%M:%SZ)
    digital_frequency=$(generate_random_frequency_in_range $digital_start_frequency $digital_end_frequency)

    # Output the communication windows
    echo "Voice Window (15 minutes): $voice_start_time - $voice_end_time | Frequency: $voice_frequency" >> $otpath
    echo "Digital Window (15 minutes): $digital_start_time - $digital_end_time | Frequency: $digital_frequency" >> $otpath
}

# Generate communication windows for the provided time ranges and frequency ranges
echo "Communication Windows for 15:00z-22:00z"
generate_communication_windows 15 22 14.150 14.350 14.000 14.150
echo >> $otpath
echo "Communication Windows for 11:00z-23:00z"
generate_communication_windows 11 23 7.125 7.300 7.000 7.125
echo >> $otpath
echo "Communication Windows for 00:00z-10:00z"
generate_communication_windows 0 10 3.600 4.000 3.500 3.600


echo " " >> $otpath
