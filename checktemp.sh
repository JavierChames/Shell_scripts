#!/bin/bash
cd /home/pi/scripts
cpuTemp0=$(cat /sys/class/thermal/thermal_zone0/temp)
cpuTemp1=$(($cpuTemp0/1000))
cpuTemp2=$(($cpuTemp0/100))
cpuTempM=$(($cpuTemp2 % $cpuTemp1))
gpuTemp=`/opt/vc/bin/vcgencmd measure_temp | awk -F '=' '{ print $2 }' | awk -F ';' '{ print $1 }' | sed s/\'//`
email=$(cat "/home/pi/scripts/email.txt")
file_pass=$(cat "/home/pi/scripts/pass.txt")
Temp_2TB=`sudo ~/scripts/HDSentinel solid | grep  Temperature | head -1 | awk -F ':' '{ print $2 }' | tr -d ' '`
Temp_4TB=`sudo ~/scripts/HDSentinel solid | grep  Temperature | tail -1 | awk -F ':' '{ print $2 }' | tr -d ' '`

<<'COMMENT'
Function to write the temperature into the log
function writeToLog() {
	The direction of the file
	you can put here another route
	file="/mnt/share/temp.log"

	Check if the file exists
	if [ ! -f "$file" ] ; then
         	if not create the file
       	touch "$file"
    	fi
echo "INSERT INTO main(Date,CPU_TEMP,GPU_TEMP) VALUES ('$(date)','$$cpuTemp1.$cpuTempM"C"','$gpuTemp');" | mysql -u root -p$file_pass PI_TEMP
	echo "$1" >> "$file"
}

Save the value
echo $(date)
echo  $cpuTemp1.$cpuTempM"C"
echo  $gpuTemp
COMMENT

echo "INSERT INTO main(Date,CPU_TEMP,GPU_TEMP) VALUES (NOW(),'$cpuTemp1.$cpuTempM"C"','$gpuTemp');" | mysql -u root -p$file_pass PI_TEMP
echo "INSERT INTO HD_TEMP(Date,HD_Temp2TB,HD_Temp4TB) VALUES (NOW(),'$Temp_2TB','$Temp_4TB');" | mysql -u root -p$file_pass PI_TEMP


#writeToLog "$(date): CPU temp - $cpuTemp1.$cpuTempM'C, GPU temp - $gpuTemp;"

# Check the temperature
if [[ "$cpuTemp1" -gt  "70" ]]; then 
  echo| mail -s  "PI is too HOT "`echo  $cpuTemp1.$cpuTempM"C"`  $file_email
#        then writeToLog "Shutdown.......;"; `shutdown -h now`
fi
