#!/bin/bash
mysql -u root -pJavi020913  -e 'select strFilename,lastPlayed from episode_view where playCount>0 order by lastPlayed\G' MyVideos93
