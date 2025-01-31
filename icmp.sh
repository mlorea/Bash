#!/bin/bash

#           $1   $2       $3
# ./imcp.sh host cantidad salida
#
#
# ./icmp.sh google.com 3 salida.txt


# Lo que devuelva el comando 'tty' se almacena en la variable 'output'.
# 
# la variable $3 alamacena lo que se haya pasado como tercer argumento al script.
# la variable output almacena el valor de $3, pero en este caso se utiliza el metodo # expansion de variables, si la variable $3 esta vacia se le asigna un valor 
# predeterminado, en este caso lo que devuelca el comando 'tty' mediante substitucion# $(comando)

output=${3:-$(tty)}





echo "Pid: $$ $0"
echo ""
echo "Parametros: $@"
echo ""
echo $output
echo ""


ping -c $2 $1 > $output

