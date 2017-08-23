#!/bin/bash
readarray -t myarray <  "/home/pi/scripts/torrent.txt"
u=${myarray[0]} 
p=${myarray[1]}
echo `transmission-remote  -n $u:$p -t $1 --remove-and-delete`


