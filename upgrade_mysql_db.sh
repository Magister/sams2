#!/bin/sh

# В этом скрипте нужно обращать внимание только на массивы versions и db_cmd.
# Количество элементов в них должно совпадать, а идеология такая:
# Чтобы обновить базу с версии versions[i-1] до версии versions[i], нужно выполнить команды db_cmd[i]
# Первый элемент в массиве db_cmd должен быть пустой


DBUSER=`grep ^DB_USER /etc/sams2.conf | awk -F'=' '{print $2}'`
DBPASS=`grep ^DB_PASSWORD /etc/sams2.conf | awk -F'=' '{print $2}'`
DBNAME=`grep ^SAMS_DB /etc/sams2.conf | awk -F'=' '{print $2}'`
mysql --user=$DBUSER --password=$DBPASS --database=$DBNAME -ss --execute="update websettings set s_version='2.0.2'"

