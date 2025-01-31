
gw=$(ip route | head -1 | cut -d " " -f 3)

dir=files

# antes de ejecutarse las intrucciones principales (copiar el contenido de el
# directorio files a un host remoto) se evalua si exite e ldirectorio files 
# y el host esta en red y hay gateway definido.
#

if [ "$gw" == "192.168.0.1" ] && [ -d $dir ]; then

		
	echo "scp -r files user@hostname:/files"
	exit 0

fi


echo "No se cunmplen los requisitos"
exit 1
