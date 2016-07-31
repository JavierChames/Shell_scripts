#!/bin/bash
cpuTemp0=$(cat /sys/class/thermal/thermal_zone0/temp)
cpuTemp1=$(($cpuTemp0/1000))
cpuTemp2=$(($cpuTemp0/100))
cpuTempM=$(($cpuTemp2 % $cpuTemp1))
gpuTemp=`/opt/vc/bin/vcgencmd measure_temp | awk -F '=' '{ print $2 }' | awk -F ';' '{ print $1 }' | sed s/\'//`

# Function to write the temperature into the log
#function writeToLog() {
	# The direction of the file
	# you can put here another route
#	file="/mnt/share/temp.log"

	# Check if the file exists
#	if [ ! -f "$file" ] ; then
         	# if not create the file
 #       	touch "$file"
  #   	fi
#echo "INSERT INTO main(Date,CPU_TEMP,GPU_TEMP) VALUES ('$(date)','$$cpuTemp1.$cpuTempM"C"','$gpuTemp');" | mysql -u root -pJavi020913 PI_TEMP
#	echo "$1" >> "$file"
#}

# Save the value
#echo $(date)
#echo  $cpuTemp1.$cpuTempM"C"
#echo  $gpuTemp
echo "INSERT INTO main(Date,CPU_TEMP,GPU_TEMP) VALUES ('$(date)','$cpuTemp1.$cpuTempM"C"','$gpuTemp');" | mysql -u root -pJavi020913 PI_TEMP
#writeToLog "$(date): CPU temp - $cpuTemp1.$cpuTempM'C, GPU temp - $gpuTemp;"

# Check the temperature
if [[ "$cpuTemp1" -gt  "70" ]]; then 
  echo| mail -s  "PI is too HOT "`echo  $cpuTemp1.$cpuTempM"C"`  haimch@gmail.com
#        then writeToLog "Shutdown.......;"; `shutdown -h now`
fi
