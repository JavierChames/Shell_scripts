#!/bin/bash
#`echo /etc/init.d/transmission-daemon status`
if [[ `ps -ef | grep trans | wc -l` < 2 ]] ; then
sudo  /etc/init.d/transmission-daemon start
fi
