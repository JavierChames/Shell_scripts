#!/bin/bash
pass_sql="pass.txt"
pass_sql=$(cat "$pass_sql")
mysql -u root -p$pass_sql  -e 'select strPath,lastPlayed from movie_view where playCount>0 order by lastPlayed\G' MyVideos93 

#mysql -u root -p$pass_sql  -e 'select strPath,lastPlayed from movie_view where playCount>0 order by lastPlayed\G' MyVideos93 | grep Path | awk -F ':' '{print$2}' | awk -F '/' '{print$5}'

