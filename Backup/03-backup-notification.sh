#!/bin/bash

#Database to be backed up and name of backed-up db
db_notification=DB_Test3
backup_db_notification=DB_Test3.sql

#Get the current date
date_now=$(date +'%Y-%b-%d')

#Go to the newly created folder
cd $date_now || exit 1

mysqldump --max-allowed-packet=16M -u root -p -f $db_notification > $backup_db_notification

#Backup the etracs notification database
if [ $? -eq 0 ]; then
	echo ""
	echo "MySQL dump completed successfully for $db_notification."
	echo ""
else
	echo ""
	echo "MySQL dump failed for $db_notification. Please check your credentials or troubleshoot issue and try again."
	[ -f "$backup_db_notification" ] && rm "$backup_db_notification"
	echo ""
	exit 1
fi

#Go back to ~/Backup folder
cd ..
