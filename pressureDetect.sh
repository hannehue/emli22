#!/bin/bash

BROKER="localhost"

USER="team22"
PWD="lobotomy"

TOPIC="$USER/trigger/pressure"

QOS="0"

mosquitto_sub -h $BROKER -u $USER -P $PWD -t $TOPIC -q $QOS | while read -r message; do
    DATETIME=$(date +"%d/%m/%Y %H:%M:%S")
    echo "$DATETIME External pressure plate triggered. Taking picture" >> /home/emli/project/pics/logs.txt
    bash "/home/emli/project/take_photo.sh" "External"
done