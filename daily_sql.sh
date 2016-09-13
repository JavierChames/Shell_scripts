#!/bin/bash
email=$(cat "/home/pi/scripts/email.txt")
pass_sql=$(cat "/home/pi/scripts/pass.txt")
mail -s'Daily report of SQL PI Temperature' $email <<EOF
$(mysql -u root -p$pass_sql  -e 'select * from (select * from main order by id desc limit 24) as dummy order by id' PI_TEMP)
$(mysql -u root -p$pass_sql  -e 'select MAX(CPU_TEMP) from(select  * from main order by id desc limit 24) as dummy order by id' PI_TEMP)
$(mysql -u root -p$pass_sql  -e 'select MIN(CPU_TEMP) from(select  * from main order by id desc limit 24) as dummy order by id' PI_TEMP)
$(mysql -u root -p$pass_sql  -e 'select * from (select * from HD_TEMP order by ID desc limit 24) as dummy order by ID' PI_TEMP)
$(mysql -u root -p$pass_sql  -e 'select MAX(HD_Temp2TB) from(select  * from HD_TEMP order by ID desc limit 24) as dummy order by ID' PI_TEMP)
$(mysql -u root -p$pass_sql  -e 'select MAX(HD_Temp4TB) from(select  * from HD_TEMP order by ID desc limit 24) as dummy order by ID' PI_TEMP)
$(mysql -u root -p$pass_sql  -e 'select MIN(HD_Temp2TB) from(select  * from HD_TEMP order by ID desc limit 24) as dummy order by ID' PI_TEMP)
$(mysql -u root -p$pass_sql  -e 'select MIN(HD_Temp4TB) from(select  * from HD_TEMP order by ID desc limit 24) as dummy order by ID' PI_TEMP)
EOF



