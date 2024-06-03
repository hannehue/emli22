#!/bin/bash
sudo sysctl -w net.ipv4.ip_forward=1
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
/home/emli/project/photos_every_sec.sh > /dev/null 2>&1 &
/home/emli/project/rain/rainDetect.sh > /dev/null 2>&1 &
/home/emli/project/rain/rainWipeMQTT.sh > /dev/null 2>&1 &
/home/emli/project/rain/rainWipeSERIAL.sh > /dev/null 2>&1 &
/home/emli/project/picServer.sh > /dev/null 2>&1 &
/home/emli/project/pressureDetect.sh > /dev/null 2>&1 &
/home/emli/project/bin/wildelifeCameraServer.sh >> /home/emli/project/camServerLogs.txt 2>&1 &
