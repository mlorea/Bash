#!/bin/bash


max_size=4000

file=/tmp/data_test.log

# espera 5 segundos entre rotacion

wait_rotator=5

data_test() {

	# esta funcion genera datos para ser usados para pruebas
	
	find / >> $file 2>&1

}


# Limite maximo en tamaño de archivo debe ser de 2048KB



actual_size() {
	
	result=$(du $file | cut -f 1)

}


# Funcion que rota los logs


log_rotator () {

	get_file=$(ls -1 ${file}* |  grep -E '[0-9]+$' | sort -t '.' -k 3n | tail -1)
 
	item=${get_file:-empty}

	if [ "$item" == "empty" ]; then

		# este bloque se ejecuta si no hay archivo terminado en 
		# numero entero.

		cp $file $file.1
	else

		# este bloque se ejecuta si hay archivos
		# terminado en numero entero.
		
		fnum=$(echo $item | cut -d "." -f 3)

		cp $file $file.$((fnum +1))

	fi

}


# genera un archivo con inforamcion


data_test
du $file




# Genera la variable 'result' con el tamño en kilobytes del archivo
actual_size

# La expresion siempre es verdadera, por lo tanto siempre se ejeucta su bloque de codigo
# esto es lo que se conoce como bucle infinito.





while :;do

	# la intrccicion 'continue' hace que todo lo que venga despues
	# no se ejeucte y se pase a la siguiente iterecion.
	
	# si el archivo esta abierto por otro proceso no se hace nada
	# se salta a la siguiente itereacion.
	
	lsof | grep $file && continue

	if [ $result -gt $max_size ];then

		# funcion que realiza la rotacion de logs.
		log_rotator
		
		du ${file}*

		sleep $wait_rotator

		# se elimina el archivo original
		rm $file

	fi

	# Añadir lineas al archivo
	
	data_test
	
	# actualizar la variable 'result'
	actual_size	


done

