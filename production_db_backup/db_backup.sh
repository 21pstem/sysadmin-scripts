#!/bin/bash

umask 077
max_backup_keep=30

function do_db_backup () {
    config_file=$1
    backup_path=$2
    environment=$3

    #gets a field from database.yml
    function get_field () {
      line=`grep $1 $config_file` #grep the line
      value=${line##*:} #get the value
      value=`echo $value | tr -d ''` #remove all white spaces
      echo $value
    }

    function trim_backups () {
	arch_files=(`ls -rt $backup_path`) #reverse list of files in an array
        count=${#arch_files[@]}
	if [ $count -gt $max_backup_keep ]
	   then
               del_count=`expr $count - $max_backup_keep`
	       del_count=`expr $del_count - 1` #normalize for zero based array
               for i in $(seq 0 $del_count)
                 do
                   rm $backup_path/${arch_files[$i]}
               done
        fi
    }
    
    pwd=`get_field password`
    databse=`get_field database`
    user=`get_field username`
    database=`get_field database`

    date=`date '+%Y-%m-%d_%H:%M:%S'`
    backup_file=daily_db_${environment}_${database}_$date.sql.bz2

    /usr/bin/mysqldump -u $user --password=$pwd --databases $database | /usr/bin/bzip2 -9 > $backup_path/$backup_file
    trim_backups
}

do_db_backup database.yml db_backups production

# note deadman snitch call is place here in production and egypt

