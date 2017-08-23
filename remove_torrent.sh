#!/bin/bash
pass_sql="/home/pi/scripts/pass.txt"
pass_sql=$(cat "$pass_sql")
username="/home/pi/scripts/torrent.txt"
username=$(cat "$username")
echo `transmission-remote  -n Javi:$pass_sql -t $1 --remove-and-delete`


