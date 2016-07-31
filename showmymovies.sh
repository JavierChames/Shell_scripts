#!/bin/bash
mysql -u root -pJavi020913  -e 'select strPath,lastPlayed from movie_view where playCount>0 order by lastPlayed\G' MyVideos93 

#mysql -u root -pJavi020913  -e 'select strPath,lastPlayed from movie_view where playCount>0 order by lastPlayed\G' MyVideos93 | grep Path | awk -F ':' '{print$2}' | awk -F '/' '{print$5}'

