#!/bin/bash

docker run -p 3306:3306 -e MYSQL_ALLOW_EMPTY_PASSWORD='yes' -d mysql:8 &

WILDLIFE_CAMERA_SSID="EMLI-TEAM-LOBOTOMY"
# WILDLIFE_CAMERA_IP="192.168.10.1"

is_connected_to_ssid() {
    current_ssid=$(nmcli -t -f ACTIVE,SSID dev wifi | grep '^yes' | cut -d':' -f2)
    if [ "$current_ssid" == "$WILDLIFE_CAMERA_SSID" ]; then
        return 0
    else
        return 1
    fi
}


while true; do
    if is_connected_to_ssid; then
        echo "Wildlife camera SSID detected. Starting other drone services"
        python3 main.py &
        ./timeSync.sh &
        ./wifi_measure.sh &
        # Exit the loop after successful sync
        break
    else
        echo "Wildlife camera SSID not detected. Retrying in 5 seconds..."
        sleep 5
    fi
done

