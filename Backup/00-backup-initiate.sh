#!/bin/bash

#Include the configuration file
source env.conf

#Prompt user to confirm if all etracs clients are shutdown
echo ""
read -p "Confirm all etracs client are shutdown? [Y/N]: " input
echo ""

#Shutdown the etracs server first
if [ "$input" = "Y" ]; then
	cd
	cd $etracs_bin
	sh stop-gdx.sh
        sh stop.sh

	cd
	cd Backup/Backup

    	#Delete the previous unfinished backup folder while retaining the MySQL Folder
    	find . ! -name 'MySQL' -type d -exec rm -rf {} +

	#Create the folder with the current date as the folder name
	mkdir -p "$date_now"
	echo ""
	echo "Backup Folder Created: $date_now" | mail -s "Backup Folder Created: $date_now" $recipient $cc $bcc
	echo ""

else
	echo "Please run the script again once all users confirmed etracs client shutdown."
	echo ""
	exit 1
fi
