#/bin/bash
API=o.iJ8on6x180u5NL9hfTauZCB1UVeAdDPg
DIRECTORY="/home/pi/Torrent"
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
         t=$(echo "$f" | awk -F'Torrent/'  '{print $2}' | awk -F'.torrent' '{print $1}' | tr '.' ' ')
		 res=$(transmission-remote -a $f )
		 result=$(echo $?)
		 if [ "$result" -ne 0 ]; then
		  case $res in
	        *duplicate*)
			echo  "$t" | mail -s  "$res"  haimch@gmail.com
			
           ;;
			*Timeout*)
			echo  Will try agian in 5 minutes | mail -s  Timeout was reached  haimch@gmail.com
	       ;;
		   *corrupt*)
			echo  Check the File | mail -s  "Torrent $t is Corrupted"  haimch@gmail.com
			
	       ;;
		  esac
		 else
		 curl -u $API: https://api.pushbullet.com/v2/pushes -d type=note -d title="Added new file to download" -d body="Added $t to download"
          #echo Added "$t" to download| mail -s  "Added $t for download"  haimch@gmail.com
          rm $f
	      
		 fi
     done
else
        echo folder is empty
        exit 1
fi
