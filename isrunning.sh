#!/bin/bash
 if [[ 3 -gt `transmission-remote -l | grep -v 100 | wc -l`  ]] ; then
    pgrep -fl torrent.sh
    if [ $? -ne 0 ]; then
      sh /home/pi/scripts/cacheclear.sh
    fi
fi
