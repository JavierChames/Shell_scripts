#!/bin/bash
email=$(cat "/home/pi/scripts/email.txt")
pass_sql=$(cat "/home/pi/scripts/pass.txt")
mail -s'Weekly  report of watched movies last week' $email <<EOF
$(mysql -u root -p$pass_sql  -e 'SELECT movie.c00 as "Movie Name", files.lastPlayed as "Watched Date" FROM files  INNER JOIN movie on files.idFile=movie.idFile WHERE lastPlayed BETWEEN (CURRENT_DATE() - INTERVAL 1 WEEK) AND CURRENT_DATE() order by lastPlayed' MyVideos107)

$(mysql -u root -p$pass_sql  -e 'SELECT strFileName as "Episode Name", lastPlayed as "Watched Date" from episode_view WHERE episode_view.lastPlayed BETWEEN (CURRENT_DATE() - INTERVAL 1 WEEK) AND CURRENT_DATE() order by episode_view.lastPlayed' MyVideos107)
EOF



