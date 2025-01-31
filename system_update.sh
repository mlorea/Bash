#!/bin/bash
# si la uid no es igual a 0
if [ $UID -ne 0 ]; then # entonces

    echo "debe ejecutar este script con privilegios de usuario 'root'"
    exit 1

fi

# actualizacion del sistema
apt update && apt upgrade -y
