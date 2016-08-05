#!/bin/bash
email=$(cat "/home/pi/scripts/email.txt")
pass_sql=$(cat "/home/pi/scripts/pass.txt")
mail -s'Daily report of SQL PI Temperature' $email <<EOF
$(mysql -u root -p$pass_sql  -e 'select * from (select * from main order by id desc limit 24) as dummy order by id' PI_TEMP)
$(mysql -u root -p$pass_sql  -e 'select MAX(CPU_TEMP) from(select  * from main order by id desc limit 24) as dummy order by id' PI_TEMP)
$(mysql -u root -p$pass_sql  -e 'select MIN(CPU_TEMP) from(select  * from main order by id desc limit 24) as dummy order by id' PI_TEMP)
EOF



