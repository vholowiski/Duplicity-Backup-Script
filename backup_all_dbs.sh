#!/bin/bash
MYSQL_ROOT_USER="your mysql root username"
MYSQL_ROOT_PASSWORD="your mysql root password"
OUTPUTDIR="/root/staging/mysql_backups"
MYSQLDUMP="/usr/bin/mysqldump"
MYSQL="/usr/bin/mysql"

#optional, uncomment to use
#MONGODIR=/root/staging/mongodb
#/usr/bin/mongodump --out $MONGODIR

ETCBACK=/root/staging/etcback
/usr/bin/rsync -r /etc/ $ETCBACK -L --delete

rm "$OUTPUTDIR/*sql" > /dev/null 2>&1

# get a list of databases
databases=`$MYSQL --user=$MYSQL_ROOT_USER --password=$MYSQL_ROOT_PASSWORD -e "SHOW DATABASES;" | tr -d "| " | grep -v Database`

for db in $databases; do
echo $db
$MYSQLDUMP --force --opt --user=$MYSQL_ROOT_USER --password=$MYSQL_ROOT_PASSWORD --databases $db > "$OUTPUTDIR/$db.sql"
done