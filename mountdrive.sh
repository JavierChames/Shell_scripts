#!/bin/sh
mounted=`mount | grep /dev/sda1`
rm -f /home/pi/harddrive.txt
if  [ -z  "$mounted" ] ; then
    echo "Mounted by script" > /home/pi/harddrive.txt
    sudo mount -a
    sleep 3
    sudo service transmission-daemon restart
    exit
    #sleep 10
    #TORRENTLIST=`transmission-remote  -l | sed -e '1d;$d;s/^ *//' | cut --only-delimited --delimiter=" "  --fields=1`
    #for TORRENTID in $TORRENTLIST
     #do
     #  transmission-remote -t $TORRENTID -s
#echo    
#done 
else
    #echo "Mounted automatically" > /home/pi/harddrive.txt
    #exit

    status_of_transmission1=`sudo service transmission-daemon status` | grep failed
    if  [  -z "$status_of_transmission1" ]  ; then
     sudo service transmission-daemon start
     echo "restart of torrent" > /home/pi/harddrive.txt
sleep 10
    TORRENTLIST=`transmission-remote  -l | sed -e '1d;$d;s/^ *//' | cut --only-delimited --delimiter=" "  --fields=1`
    for TORRENTID in $TORRENTLIST
     do
       transmission-remote -t $TORRENTID -s
     done 

     exit
    else
    status_of_transmission=`sudo service transmission-daemon status` | grep running
    if  [  -z "$status_of_transmission" ]  ; then
    echo "Already running"
exit 
fi
fi
fi
