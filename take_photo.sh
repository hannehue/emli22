#!/bin/bash
TIME=$(date +"%H%M%S_%3N")
DATE=$(date +"%Y-%m-%d")

if ! test -d ~/project/pics/$DATE; then
  mkdir ~/project/pics/$DATE
fi

FILE=~/project/pics/$DATE/$TIME

rpicam-still -t 0.01 -o $FILE.jpg

touch $FILE.json

METADATA=$(exiftool -json $FILE.jpg)

# Extract subject distance, exposure time, and ISO from metadata
SubjectDistance=$(echo "$METADATA" | jq -r '.[0]."SubjectDistance"')
ExposureTime=$(echo "$METADATA" | jq -r '.[0]."ExposureTime"')
ISO=$(echo "$METADATA" | jq -r '.[0]."ISO"')

json_body='{
  "File Name": "'$TIME.jpg'",
  "Create Date": "'$(date +'%Y-%m-%d %H:%M:%S.%3N%:z')'",
  "Create Seconds Epoch": '$(date +%s.%3N)',
  "Trigger": "'$1'",
  "Subject Distance": "'$SubjectDistance'",
  "Exposure Time": "'$ExposureTime'",
  "ISO": "'$ISO'"
}'

DATETIME=$(date +"%d/%m/%Y %H:%M:%S")
echo "$DATETIME Took photo with flag: $1" >> /home/emli/project/pics/logs.txt

echo $json_body > $FILE.json
echo "Photo $FILE.jpg taken with trigger $1"