#! /bin/bash

if [ -e ~/TRASH ]   # check if file TRASH exists
then
	#Do_Nothing
	echo
else
	mkdir ~/TRASH                                                       #make TRASH directory
	chmod 777 ~/TRASH	                                            
	(crontab -l 2>/dev/null; echo "*/30 * * * * sdel.sh") | crontab -   #crontab run this script every 30minutes
fi

find ~/TRASH -type f -mtime +1.95833333333333333 -exec rm -f {} \;          #remove files older than 48hrs

if [ "$1" == "-h" ]                                                         #type -h as an option to get help
then
	echo
	echo "NAME"
	echo "       sdel.sh - Safe Delete Application"
	echo
	echo "SYNOPSIS"
	echo "       sdel.sh [file/files/directory/directories]..."
	echo
	echo "DESCRIPTION"
        echo "       Compress and zip files and directories to ~/TRASH folder (48 hours) lifetime."
	echo
	echo "AUTHOR"
	echo "       Developed by: Ahmed Zoher (ahmed.o.zoher@gmail.com)"
	echo 
else
	while [ -n "$1" ]                                                  #get all options (files/directories)
	do
		file $1 | grep 'compressed' > /dev/null                   #check if is compressed
		if [ $? == 0 ]
		then 	
			if [ -d $1 ]                                      #check if directory then compress files and zipp directories recursively
			then
				gzip -r $1
				find . -mindepth 1 -maxdepth 4 -type d | xargs -I {} tar -cf {}.tar {}
				rm $1.tar
				tar cf ~/TRASH/$1.tar $1
			else
				tar cf ~/TRASH/$1.tar.gz $1
			fi
		else
			if [ -d $1 ]
			then
				gzip -r $1
				find . -mindepth 1 -maxdepth 4 -type d | xargs -I {} tar -czf {}.tar.gz {}
				rm $1.tar.gz
				tar czf ~/TRASH/$1.tar.gz $1
			else			
				tar czf ~/TRASH/$1.tar.gz $1
			fi
		fi
		shift
	done
fi
