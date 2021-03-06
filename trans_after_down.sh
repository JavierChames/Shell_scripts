	#!/bin/bash	
	# the folder to move completed downloads to
	clear
	unset array
	MOVEDIR=/mnt/share/
	Series2TB=/mnt/share/Series
	Series4TB=/mnt/share4TB/Series
	app=false
	file="/mnt/share/mygit/email.txt"
	email=$(cat "$file")
	flag=false
	notregularfile=file
	serie_space=false
	x=0
		
	# use transmission-remote to get torrent list from transmission-remote list
	# use sed to delete first / last line of output, and remove leading spaces
	# use cut to get first field from each line

	TORRENTLIST=`transmission-remote  -l | sed -e '1d;$d;s/^ *//' | cut --only-delimited --delimiter=" "  --fields=1`
	# for each torrent in the list

	 function found_series() {
								arg1=$1
								echo "Moving downloaded file(s) to $MOVEDIR/$arg1 | awk -F '/' '{print $1}'"
								 transmission-remote -t $TORRENTID --move "$MOVEDIR/$arg1"
								 echo "$Name1" finish download...and moved to "$MOVEDIR/$arg1"   | mail -s  "Finish $Name1" $email
								flag=true
								}								
								
	function found_availabe_space() {
								spaceindrivesda1=`df -h | grep sda1  | awk -F" " '{ print $4 }' | awk -F"G" '{ print $1 }' | awk -F"." '{ print $1 }'`
								arg1=$1
                                arg2=$2
								echo $arg1
								echo $arg2
								
								if  [[ `transmission-remote -t $TORRENTID -i | grep Downloaded | awk -F": " '{ print $2 }'` =~ MB ]]; then
				                        spaceindrivesda1=$spaceindrivesda1*1000
				                        spaceindrivesda1=$spaceindrivesda1-1000
										echo the content of flag is:$flag
								elif [[ `transmission-remote -t $TORRENTID -i | grep Downloaded | awk -F": " '{ print $2 }'` =~ GB ]]; then
									     spaceindrivesda1=$spaceindrivesda1*1
								     elif [[ `transmission-remote -t $TORRENTID -i | grep Downloaded | awk -F": " '{ print $2 }'` =~ TB ]]; then
									                   spaceindrivesda1=$spaceindrivesda1
								 fi
									 echo $arg2
								     if [ $arg2 == Series ] ; then
					                           if [[ $spaceindrivesda1  -gt `transmission-remote -t $TORRENTID -i  | grep Downloaded | awk -F": " '{ print $2 }'  | awk -F"TB" '{ print $1 }' | awk -F"." '{ print $1 }'` ]]  ; then
   						                             array=( $( ls $Series2TB -1p))
													 echo series
						                             MOVEDIR=/mnt/share/Series
                	                 			else 
						                             array=( $( ls $Series4TB -1p))
						                             MOVEDIR=/mnt/share4TB/Series
								                fi
								     else	
								            if [ $arg2 == Movie ] ; then 
									               if [[ $spaceindrivesda1  -gt `transmission-remote -t  $TORRENTID -i | grep Downloaded | awk -F": " '{ print $2 }'  | awk -F"GB" '{ print $1 }' | awk -F"." '{ print $1 }'` ]]  ; then
                                                       echo movies
									                    MOVEDIR=/mnt/share/Movies
                                                    else 
                                                         MOVEDIR=/mnt/share4TB/Movies
                                                     fi
                                            else
									          if [ $arg2 == Music ] ; then 
                                                   if [[ $spaceindrivesda1  -gt `transmission-remote -t  $TORRENTID -i  | grep Downloaded | awk -F": " '{ print $2 }'  | awk -F"MB" '{ print $1 }' | awk -F"." '{ print $1 }'` ]]  ; then
                                                             MOVEDIR=/mnt/share/Music
                                                   else 
                                                              MOVEDIR=/mnt/share4TB/Music
	                            					fi
								              else
									          if [ $arg2 == Apps ] ; then 
                                                 if [[ $spaceindrivesda1  -gt `transmission-remote -t  $TORRENTID -i | grep Downloaded | awk -F": " '{ print $2 }'  | awk -F"MB" '{ print $1 }' | awk -F"." '{ print $1 }'` ]]  ; then
                                                         MOVEDIR=/mnt/share/Apps
                                                 else 
                                                         MOVEDIR=/mnt/share4TB/Apps
                                                 fi
				    			              fi

                                   			fi
							        fi
									fi
									}

	for TORRENTID in $TORRENTLIST
	do
		# check if torrent download is completed & location is only in tmp folder
		DL_COMPLETED=`transmission-remote -t $TORRENTID -i | grep "Percent Done: 100%"`
		LOCATION=`transmission-remote -t $TORRENTID -i | grep "Location: /mnt/share4TB/tmp"`
		 Name1=`transmission-remote -t $TORRENTID -i | grep Name | awk -F ':' '{print $2}' | cut -c 2- |  tr . ' '` # Zaguri Empire S02E05 720p HDTV x264-LironTV mkv
		 Series=`transmission-remote -t $TORRENTID -i | grep Name | grep S[0-9][0-9]E[0-9][0-9]` #'  Name: Zaguri.Empire.S02E05.720p.HDTV.x264-LironTV.mkv'
		  if   [  "$LOCATION"  ] && [  "$DL_COMPLETED"  ]; then #Check if currnet torrent is in tmp folder and state of current torrent is 100 % done
			 if [ "$Series" ]; then #if its a series then...
				SeriesName=`echo $Name1 | awk -F "S[0-9][0-9]E[0-9][0-9]" '{print $1}'`
				 if [[ "$SeriesName" =~ \ |\' ]] ; then
						  serie_space=true
						  SeriesName=$(echo $SeriesName | sed 's/ //g') #Set Series name witouth spaces
				 fi	
				 found_availabe_space $TORRENTID Series #call to check space in disk
						for i in "${array[@]}"
					      do
					             i=$(echo $i | awk -F '/' '{print $1}')
					                    if [[ $SeriesName =~ $i ]] | [[ `echo $SeriesName | awk  '{print tolower($0)}'`  =~ $i ]]; then
						                    found_series  $i
						                    break
						                else 
										   continue
			   		fi
				  done	
					  if [[ $flag == false ]]; then #added manually but folder doesn't exists
		
			#mkdir $MOVEDIR$SeriesName
						   found_series $SeriesName
					 fi
					 else
				Music_torrent_MP3=`transmission-remote -t $TORRENTID -if | grep mp3` #check if its a MP3 file
				Music_torrent_FLAC=`transmission-remote -t $TORRENTID -if | grep flac` #check if its a flac file
				   if  [[ "$Music_torrent_MP3" ]] || [[ "$Music_torrent_FLAC" ]]; then 
                       found_availabe_space $TORRENTID Music
					  transmission-remote -t $TORRENTID --move $MOVEDIR
				   else  
				   if	 [[ $app == false ]]; then		   
					found_availabe_space $TORRENTID Movie
					  echo "Moving downloaded file(s) to $MOVEDIR" #its a Movie so move it to movie
					  transmission-remote -t $TORRENTID --move $MOVEDIR
					  echo "$Name1" finish download...and moved to "$MOVEDIR"  | mail -s  "Finish $Name1" $email
				   else 	  
				found_availabe_space $TORRENTID Apps
				   echo "Moving downloaded file(s) to $MOVEDIR" #its something else
					  transmission-remote -t $TORRENTID --move $MOVEDIR
					  echo "$Name1" finish download...and moved to "$MOVEDIR"  | mail -s  "Finish $Name1" $email
				   fi	  
				  fi
				fi	
		else 
		continue
		fi
		while [ `free -m | grep Mem | awk -F ' ' '{print $4}'` -lt 150 ]; do
		sleep 5
		let "x++"
		if [ $x == 12 ]; then
		sudo sh -c "sync; echo 3 > /proc/sys/vm/drop_caches"
		    break
		fi
		done
		x=0
		flag=false
	done
