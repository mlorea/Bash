#!/bin/bash


# Niveles de alarma (% de uso)
#
# war: mayor a 50 pero menor a 70
# crit: mayor a 70 menor a 95
# err: mayor a 95

# Uso del script
#
# ./disk-usage-warning.sh /dev/sdX
#

disk=$1

err_warn="[WARNING] El dipositivo $disk esta alcanzando el 70% de uso." 
err_crit="[CRITICAL] El dipositivo $disk esta alcanzando el 95% de uso." 
err_err="[ERROR] El dipositivo $disk esta alcanzando el %100 de uso." 
err_info="[INF] El dipositivo $disk esta al:" 


# el signo '!' invierte el sentido de la expresion, si devuelve Verdadero se
# interpreta como Falso, si devuelve Falso se interpreta como Verdadero.
#
# En este caso queremos que se ejecuten los comandos de la expresion si
# '$disk' NO es un archivo especial de bloque.

if [ -b $disk ];then
	
	disk_size=$(df $disk -h | grep '/dev/sda1' | tr -s ' ' | cut -d ' ' -f 2)
	disk_perc=$(df -h $disk | grep '/dev/sda1' | tr -s ' ' | cut -d ' ' -f 5 | sed 's/%//')

else

	echo "$disk no es un dipositivo de bloque"
	exit 1

fi 


disk_perc=95


# mayor a 50 y menor que 70

if [ $disk_perc -ge 50 ] &&  [ $disk_perc -lt 70 ]; then

	echo $err_warn

elif [ $disk_perc -ge 70 ] &&  [ $disk_perc -lt 95 ]; then
	 
	echo $err_crit

elif [ $disk_perc -ge 95 ];then

	echo $err_err

else

	echo $err_info ${disk_perc}%

fi

