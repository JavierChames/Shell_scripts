#!/bin/bash
inputfile="/mnt/share/temp.log"
echo $inputfile
cat $inputfile |  while read F
do
  DATE=$(echo $F |  awk -F ': CPU' '{ print $1 }')
  echo $DATE

  CPU=$(echo $F  | awk -F ': ' '{ print $2 '} | awk -F ', ' '{ print $1 }' | awk -F ' - ' '{ print $2 }' | sed s/\'//) 
  echo $CPU
  GPU=$(echo $F  | awk -F 'C, ' '{ print $2 }' | awk -F 'temp=' '{ print $2 }'  | awk -F ';' '{ print $1 }' | sed s/\'//)
  echo $GPU
echo "INSERT INTO main(Date,CPU_TEMP,GPU_TEMP) VALUES ('$DATE','$CPU','$GPU');" | mysql -u root -pJavi020913 PI_TEMP
done 
