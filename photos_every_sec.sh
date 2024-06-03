#!/bin/bash
IMAGE_DIR="/home/emli/project/pics"
MOTION_CHECK_SCRIPT="/home/emli/project/motion_detect.py"
DELAY=3 # Delay in seconds
KEEP_IMAGE=false

# Create the image directory if it doesn't exist
sudo -uemli mkdir -p "$IMAGE_DIR"

prev_image=""
current_image=""

while true; do
    # Generate a timestamp-based image filename
    TIME=$(date +"%H%M%S_%3N")
    FILENAME="$TIME.jpg"
    DATE=$(date +"%Y-%m-%d")
    sudo -uemli mkdir -p "$IMAGE_DIR/$DATE"
    current_image="$IMAGE_DIR/$DATE/$FILENAME"

    rpicam-still -t 0.01 -o "$current_image"

    # Check if there is a previous image to compare against
    if [ -n "$prev_image" ]; then
        # Use the motion check script to check for motion
        motion_result=$(python3 "$MOTION_CHECK_SCRIPT" "$prev_image" "$current_image")
        if [ "$motion_result" == "Motion detected" ]; then
            # If motion is detected, set the flag to keep the last picture
            KEEP_IMAGE=true
            bash "/home/emli/project/take_photo.sh" "Motion"
        fi

        # Before removing prev_image, check for a JSON file with the same base name
        FILE="${prev_image%.*}.json"
        if [ -f "$FILE" ]; then
            echo "JSON file exists for $prev_image, keeping image file."
        else
            # If no JSON file exists, remove the previous image
            rm "$prev_image"
        fi
    fi

    # Update the previous image to the current one
    prev_image="$current_image"

    # If motion was detected and we need to keep the last picture
    if $KEEP_IMAGE; then
        echo "Motion detected! Keeping image: $lprev_image"
        KEEP_IMAGE=false # Reset the flag
    fi

    # Delay for the specified time interval
    sleep $DELAY
done
