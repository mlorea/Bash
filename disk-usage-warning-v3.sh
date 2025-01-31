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
	local err_info="[INF] El dipositivo $disk esta al: $2%" 

	case opcion in

	# si 'opcion' es igual a '1' o '2' o '3' o cualquier otra cadena
	# que no sea '1','2' o '3'.

		1) echo $err_warn
			;;
		2) echo $err_crit
			;;
		3) echo $err_err
			;;
		*) echo $err_info
			;;
	esac

}



func_mountpoint_check() {

	mount | grep -w $1 && return 0 || return 1
}


if func_mountpoint_check $disk > /dev/null ;then
	
	disk_size=$(df $disk -h | grep $disk | tr -s ' ' | cut -d ' ' -f 2)
	disk_perc=$(df -h $disk | grep $disk | tr -s ' ' | cut -d ' ' -f 5 | sed 's/%//')

else

	echo "$disk no es un dipositivo de bloque o no tiene punto de montaje."
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

