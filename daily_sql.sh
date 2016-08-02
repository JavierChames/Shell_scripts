#!/bin/bash
file_email="/home/pi/scripts/email.txt"
email=$(cat "$file_email")
pass_sql="/home/pi/scripts/pass.txt"
pass_sql=$(cat "$pass_sql")
mail -s'Daily report of SQL PI Temperature' $email <<EOF
$(mysql -u root -p$pass_sql  -e 'select * from (select * from main order by id desc limit 24) as dummy order by id' PI_TEMP)
$(mysql -u root -p$pass_sql  -e 'select MAX(CPU_TEMP) from(select  * from main order by id desc limit 24) as dummy order by id' PI_TEMP)
$(mysql -u root -p$pass_sql  -e 'select MIN(CPU_TEMP) from(select  * from main order by id desc limit 24) as dummy order by id' PI_TEMP)
EOF



