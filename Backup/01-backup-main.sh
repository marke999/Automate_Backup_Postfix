#!/bin/bash

#Configuration file
source env.conf

#Go to the newly created folder
cd $date_now || exit 1

mysqldump --max-allowed-packet=16M -u root -p -f $db_etracs > $backup_db_etracs

#Backup the etracs main database
if [ $? -eq 0 ]; then
	echo ""
    echo "MySQL dump completed successfully for $db_etracs."
	echo "MySQL dump completed successfully for $db_etracs." | mail -s "MySQL dump completed successfully for $db_etracs" $recipient $cc $bcc
	echo ""
else
	echo ""
	echo "MySQL dump failed for $db_etracs. Please check your credentials or troubleshoot issue and try again."
	echo "$log_content" | mail -s "MySQL dump failed for $db_etracs" $recipient $cc $bcc
	[ -f "$backup_db_etracs" ] && rm "$backup_db_etracs"
	echo ""
	exit 1
fi

#Go back to ~/Backup folder
cd ..
