#/bin/bash
email=$(cat "/home/pi/scripts/email.txt")
API=$(cat "/home/pi/scripts/api.txt")
DIRECTORY="/home/pi/Torrent"
Zip_files="/home/pi/Torrent/*.zip"
if [ -e $Zip_files ]; then
    for zipfile in /$Zip_files
      do 
        unzip  $zipfile -d /home/pi/Torrent
     done 
     rm $zipfile
fi
if [ "$(ls -A  $DIRECTORY)" ]; then 
  for f in $DIRECTORY"&/*.torrent"
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
