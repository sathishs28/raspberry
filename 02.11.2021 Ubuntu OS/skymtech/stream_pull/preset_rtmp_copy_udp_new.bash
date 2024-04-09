#!/bin/bash

# Check the Raspberry PI Serial Number

ID=100000002c7943f5
SERIAL_NO=$(cat /proc/cpuinfo | grep Serial | cut -d ' ' -f 2)

if [ $SERIAL_NO == $ID ]
then

# Enable Multicast IP route

/usr/local/bin/./enable_multicast

        echo -e " Device Matched ... \n"

ffmpeg -threads 4 -f flv  -re -y -rw_timeout 1000000 -i $INPUT_URL \
  -c:v copy -c:a aac -b:a 128k \
  -threads 4 -mpegts_pmt_start_pid $PMT_PID -streamid 0:$VIDEO_PID -streamid 1:$AUDIO_PID \
  -metadata service_provider="SKYM TECH" -metadata service_name="$STREAM_NAME" \
  -f mpegts "$OUTPUT_URL?pkt_size=1316&localaddr=$OUTPUT_INTERFACE_IP" \
</dev/null > /dev/null 2>&1 & echo $! > $STREAM_PID_PATH

else
        echo -e " \n ###----- Device not Matched -----### \n"

fi











