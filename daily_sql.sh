#!/bin/bash
mail -s'Daily report of SQL PI Temperature' haimch@gmail.com <<EOF
$(mysql -u root -pJavi020913  -e 'select * from (select * from main order by id desc limit 24) as dummy order by id' PI_TEMP)
$(mysql -u root -pJavi020913  -e 'select MAX(CPU_TEMP) from(select  * from main order by id desc limit 24) as dummy order by id' PI_TEMP)
$(mysql -u root -pJavi020913  -e 'select MIN(CPU_TEMP) from(select  * from main order by id desc limit 24) as dummy order by id' PI_TEMP)
EOF
# ;
# | mail -s "SQL results"  haimch@gmail.com

