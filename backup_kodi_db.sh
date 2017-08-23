#!/bin/bash

time=$(date +'%d%m%Y')
echo $time
mkdir /mnt/share/backup/kodi_db/$time
$(mysqldump --user=KodiUser --password=KodiPassword --databases MyVideos107 > /mnt/share/backup/kodi_db/$time/MyVideos107.sql)
