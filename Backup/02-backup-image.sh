#!/bin/bash

#Database to be backed up and name of backed-up db
db_image=DB_Test2
backup_db_image=DB_Test2.sql

#Get the current date
date_now=$(date +'%Y-%b-%d')

#Go to the newly created folder
cd $date_now || exit 1

mysqldump --max-allowed-packet=16M -u root -p -f $db_image > $backup_db_image

#Backup the etracs image database
if [ $? -eq 0 ]; then
	echo ""
	echo "MySQL dump completed successfully for $db_image."
	echo ""
else
	echo ""
	echo "MySQL dump failed for $db_image. Please check your credentials or troubleshoot issue and try again."
	[ -f "$backup_db_image" ] && rm "$backup_db_image"
	echo ""
	exit 1
fi

#Go back to ~/Backup folder
cd ..
