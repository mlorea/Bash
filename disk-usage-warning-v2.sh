#!/bin/bash


# Uso del script
#
# ./disk-usage-warning.sh /dev/sdX
#

disk=$1


err_msg() {

	local err_warn="[WARNING] El dipositivo $disk esta alcanzando el 70% de uso: $2".
	local err_crit="[CRITICAL] El dipositivo $disk esta alcanzando el 95% de uso: $2" 
	local err_err="[ERROR] El dipositivo $disk esta alcanzando el %100 de uso: $2" 
	local err_info="[INF] El dipositivo $disk esta al: $2" 

	if [ $1 -eq 1 ];then

		echo $err_warn

	elif [ $1 -eq 2 ];then

		echo $err_crit

	elif [ $1 -eq 3 ];then

		echo $err_err

	else
		echo $err_info

	fi
}



func_volume_chek() {

	[ -b $disk ] && return 0 || return 1
}


if func_volume_check;then
	
	disk_size=$(df $disk -h | grep $disk | tr -s ' ' | cut -d ' ' -f 2)
	disk_perc=$(df -h $disk | grep $disk | tr -s ' ' | cut -d ' ' -f 5 | sed 's/%//')

else

	echo "$disk no es un dipositivo de bloque"
	exit 1

fi 


#disk_perc=95



if [ $disk_perc -ge 50 ] &&  [ $disk_perc -lt 70 ]; then

	err_msg 1 $disk_perc 

elif [ $disk_perc -ge 70 ] &&  [ $disk_perc -lt 95 ]; then
	 
	err_msg 2 $disk_perc 

elif [ $disk_perc -ge 95 ];then

	err_msg 3 $disk_perc 

else

	err_msg 0 $disk_perc 	

fi

