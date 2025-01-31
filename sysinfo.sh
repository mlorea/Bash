#!/bin/bash
 
# Variables
# la variable 'usuario' tiene el valor posicional '$1'.
 
usuario=$1
fecha="$(date)"
systemuser="$USER ($UID)"
terminal="$(tty | cut  -c 6-)"
 
 
memoria="$(cat /proc/meminfo | grep MemTotal)"
cpu="$(cat /proc/cpuinfo | grep "model name" | head -1)"
 
source /etc/os-release
 
 
echo "Fecha: $fecha 
Generado por: $usuario
Usuario del sistema: $systemuser
Terminal: $terminal 
 
 -- Informacion del SO --
 
 
Nombre: $NAME
Version: $VERSION
 
recursos del sistema
 
$memoria
 
$cpu
" | tee informe.txt
