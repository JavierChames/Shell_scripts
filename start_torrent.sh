#!/bin/bash
email=$(cat "/home/pi/scripts/email.txt")
API=$(cat "/home/pi/scripts/api.txt")
DIRECTORY="/home/pi/Torrent"
readarray -t myarray <  "/home/pi/scripts/torrent.txt"
u=${myarray[0]} 
p=${myarray[1]}
if [ -e /home/pi/Torrent/*.zip ]; then
    for zipfile in /home/pi/Torrent/*.zip
      do 
        unzip  $zipfile -d /home/pi/Torrent
     done 
     rm $zipfile
fi
if [ "$(ls -A  $DIRECTORY)" ]; then 
  for f in /home/pi/Torrent/*.torrent
     do 
         torrent_Name=$(echo "$f" | awk -F'Torrent/'  '{print $2}' | awk -F'.torrent' '{print $1}' | tr '.' ' ')
		 res=$(transmission-remote -n $u:$p -a "$f" )
		 result=$(echo $?)
		 if [ "$result" -ne 0 ]; then
		  case $res in
	        *duplicate*)
			echo  "$torrent_Name" | mail -s  "$res"  $email

           ;;
			*Timeout*)
			echo  Will try agian in 5 minutes | mail -s  Timeout was reached  $email
	       ;;
		   *corrupt*)
			echo  Check the File | mail -s  "Torrent $torrent_Name is Corrupted"  $email
	       ;;
		  esac
		 else
         		 curl -u $API: https://api.pushbullet.com/v2/pushes -d type=note -d title="Added new file to download" -d body="Added $torrent_Name to download"
                        rm "$f"
	        fi
     done
else
        echo folder is empty
        exit 1
fi
