#!/bin/bash
readarray -t myarray <  "/home/pi/scripts/torrent.txt"
u=${myarray[0]} 
p=${myarray[1]
sudo mount -a
sleep 5
num_of_torrent=` transmission-remote -n Javi:Javi020913 -l | wc -l` 
num_of_torrent=$((num_of_torrent-2))
echo "$num_of_torrent"
transmission-remote -n $u:$p -t 1-$num_of_torrent -s
sleep 5
sudo service nfs-kernel-server force-reload
sudo service minidlna force-reload
