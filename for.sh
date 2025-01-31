

# se define un array
#  indice 0       1     2         3       4
nombres=("Alice" "Bob" "Charlie" "Diana" "Eve")


echo ${nombres[0]} # imprime 'Alice'
echo ${nombres[2]} # imprime 'Charlie'
echo ${nombres[-1]} # imprime 'Eve'
echo ${nombres[-2]} # imprime 'Diana'


echo ""
# imprime todos linea a linea
# el valor de 'item' se asigna con cada elemento
# del array en cada vuelta.
for item in ${nombres[@]}; do

	echo usuario: $item

done
