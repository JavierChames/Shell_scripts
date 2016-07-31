#/bin/bash
file_email="email.txt"
email=$(cat "$file_email")
API_file="api.txt"
API=$(cat "$API_file")
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
			echo  "$t" | mail -s  "$res"  $file_email
			
           ;;
			*Timeout*)
			echo  Will try agian in 5 minutes | mail -s  Timeout was reached  $file_email
	       ;;
		   *corrupt*)
			echo  Check the File | mail -s  "Torrent $t is Corrupted"  $file_email
			
	       ;;
		  esac
		 else
		 curl -u $API: https://api.pushbullet.com/v2/pushes -d type=note -d title="Added new file to download" -d body="Added $t to download"
          #echo Added "$t" to download| mail -s  "Added $t for download"  $file_email
          rm $f
	      
		 fi
     done
else
        echo folder is empty
        exit 1
fi
