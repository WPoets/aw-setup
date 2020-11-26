#!/usr/bin/env bash
# Back up Script to Amazon S3
# Source: 
# Author: Amit

#path to WordPress installations
SITESTORE=/var/www

#S3 bucket
S3DIR="s3://<BUCKETNAME>/"

MYSQL_USER='DBUSER'
MYSQL_PASS='DBPASSWORD'

DATE=$(date +%Y%m%d)
LOGFILE=/var/log/s3backup/$DATE.log
EMAIL=''

mkdir -p /var/log/s3backup
touch $LOGFILE

#create array of sites based on folder names
#SITELIST=($(ls -lh $SITESTORE | awk '{print $9}'))
SITELIST=($(/usr/local/bin/wo site list --enabled | sed 's/\x1b\[[0-9;]*[a-zA-Z]//g'))

#start the loop
for SITE in ${SITELIST[@]}; do
    echo Backing up $SITE
    #enter the WordPress folder
    #cd $SITESTORE/$SITE
    if [ $SITE == '22222' ]|| [ $SITE == 'html' ]; then
        echo Skipping $SITE
		continue
		
    fi
	
	
	DBNAME=($(/usr/local/bin/wo site info $SITE | awk -v FS="(DB_NAME)" '{print $2}' | sed -e 's/[[:space:]]*$//'))
		
	echo database is $DBNAME
	if [ ! -e $SITESTORE/$SITE/db ]; then
        mkdir $SITESTORE/$SITE/db
    fi
	#back up the WordPress database
	mysqldump -u $MYSQL_USER -p$MYSQL_PASS --routines --single-transaction --quick --lock-tables=false $DBNAME | gzip -9 > $SITESTORE/$SITE/db/$DBNAME.sql.gz
	
done
 #back up the WordPress folder
/usr/local/bin/aws s3 sync $SITESTORE/ $S3DIR --exclude 'html' --exclude '.git/*' --exclude 'logs/*' --profile default | tee -a $LOGFILE

#/usr/bin/mail -s "Backup report for KABIR DO Server ON $DATE" $EMAIL < $LOGFILE

