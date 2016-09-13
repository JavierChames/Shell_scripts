#!/bin/bash
DB="MyVideos93"
pass_sql="/home/pi/scripts/pass.txt"
pass_sql=$(cat "$pass_sql")
mysql -u root -p$pass_sql  -e 'select strPath,lastPlayed from movie_view where playCount>0 order by lastPlayed\G' $DB 

#mysql -u root -p$pass_sql  -e 'select strPath,lastPlayed from movie_view where playCount>0 order by lastPlayed\G' $DB | grep Path | awk -F ':' '{print$2}' | awk -F '/' '{print$5}'

