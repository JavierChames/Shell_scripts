#!/bin/bash
pass_sql="pass.txt"
pass_sql=$(cat "$pass_sql")
mysql -u root -p$file_pass  -e 'select strFilename,lastPlayed from episode_view where playCount>0 order by lastPlayed\G' MyVideos93
