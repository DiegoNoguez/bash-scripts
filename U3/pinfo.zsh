#!/bin/bash

# Solicita el nombre de la aplicación
read -p "Ingresa el nombre de la aplicación: " aplicacion

# Obtiene el PID de la aplicación
idprocess=$(pgrep -o $aplicacion)  # Utiliza -o para obtener el primer PID encontrado
# Obtiene el tamaño de la memoria en KB (debería estar en la última línea de pmap)
peso=$(pmap $idprocess | awk '/total/ {print $2}' | sed 's/K$//' )
#echo "$peso"

valor=1024
pMB=$(echo "scale=2; $peso / $valor" | bc)
#echo "$pMB"
pfinal=$(echo $pMB | sed -e 's/^.//')
# Muestra los resultados
echo "--------------------------------"
echo "Total de memoria para el PID $idprocess"
echo "--------------------------------"
echo "Memoria usada: $pfinal  MB"
