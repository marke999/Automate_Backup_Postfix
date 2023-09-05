#!/bin/bash

#Get the current date
date_now=$(date +'%Y-%b-%d')

#Maximum no. of backup files
max_files=2

cd MySQL
while [ "$(ls -1 | wc -l)" -ge "$max_files" ]; do
    oldest_file=$(ls -1tr | head -1)
    rm "$oldest_file"
done
scp lgucebu1@192.168.1.196:/home/lgucebu1/Backup/MySQL/"$date_now.tar.gz
