#!/bin/bash
DB="MyVideos93"
pass_sql="/home/pi/scripts/pass.txt"
pass_sql=$(cat "$pass_sql")
mysql -u root -p$pass_sql  -e 'select strFilename as "File name",lastPlayed as "Watched date" from episode_view where playCount>0 order by lastPlayed\G' $DB
