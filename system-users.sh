#!/bin/bash

# Extraer usuarios con UID mayor o igual a 500
usuarios=$(awk -F: '$3 >= 500 {print $1}' /etc/passwd)

echo $usuarios


echo "Usuarios con UID 500 o mayor:"

# Iterar sobre cada usuario
for usuario in $usuarios; do
    echo "Usuario: $usuario"
done
~      
