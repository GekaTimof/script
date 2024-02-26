#!/bin/bash

# params 1 -> file to backup
file_to_backup=$1
directory_to_backups="Backups_"$1


# check the backups directory
if [ ! -d $directory_to_backups ];
then
        mkdir $directory_to_backups
        echo "directory was create"
fi


# time argument
min=$2
let find_time=$min/24/60
backup_time=$min"m"


# backup function
neat_backup() {
    while true;
    do
	sleep $backup_time
	file=$(find . -name "$file_to_backup" -mtime -$find_time)
	if [ ! -z $file ];
	then
        	backup_file=$directory_to_backups"/backup_$(date +'%Y%m%d%H%M%S').txt"
        	cp "$file_to_backup" "$backup_file"
	        echo "Backup created: $backup_file"
	else
		echo "file didn't change"
	fi

    done
}

# Start neat backuping
neat_backup

