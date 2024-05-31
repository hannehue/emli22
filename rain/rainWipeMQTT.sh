#!/bin/bash

BROKER="localhost"

USER="team22"
PWD="lobotomy"

TOPIC="$USER/rain"
TOPICPUB="$USER/wiper"

QOS="0"

mosquitto_sub -h $BROKER -u $USER -P $PWD -t $TOPIC -q $QOS | while read -r message; do
    DATETIME=$(date +"%d/%m/%Y %H:%M:%S")
    echo "$DATETIME Wiping lens" >> /home/emli/project/pics/logs.txt
    echo "Received message: $message"
    mosquitto_pub -h $BROKER -u $USER -P $PWD -t $TOPICPUB -m '{"wiper_angle": 0}'
    sleep 0.5
    mosquitto_pub -h $BROKER -u $USER -P $PWD -t $TOPICPUB -m '{"wiper_angle": 180}'
    sleep 0.5
    mosquitto_pub -h $BROKER -u $USER -P $PWD -t $TOPICPUB -m '{"wiper_angle": 0}'
done