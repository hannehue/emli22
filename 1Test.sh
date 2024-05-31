#!/bin/bash

# Capture image with rpicam-still
rpicam-still -t 0.01 -o test.jpg

# Get exposure time
# exposure_time=$(raspistill --verbose -o test.jpg 2>&1 | grep -oP 'exposure_time=\K[0-9]+')

  metadata=$(exiftool -json /home/emli/project/test.jpg)

  # Extract subject distance, exposure time, and ISO from metadata
  subject_distance=$(echo "$metadata" | jq -r '.[0]."SubjectDistance"')
  exposure_time=$(echo "$metadata" | jq -r '.[0]."ExposureTime"')
  iso=$(echo "$metadata" | jq -r '.[0]."ISO"')

# Print exposure time
echo "subject distance: $subject_distance µs"
echo "Exposure Time: $exposure_time "
echo "iso: $iso "
