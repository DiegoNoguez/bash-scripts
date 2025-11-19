#! /bin/bash

echo "Bienvenido selecciona el Script que desees ejecutar"
echo "1--> Generar scripts automaticos del 1 al 50 con terminacion de a la z con cada archivo"
echo "2--> Ordenar los scripts creados del anterior Script" 
echo "Advertencia sino no has ejecutado el primer script al menos una vez ejecutalo"
echo "Y despues de ejecutar el segundo script volver a ejecutarlo"
read -p "Ingresa el numero del script que deseas ejecutar " num


if [ 1 -eq $num ]; then 
    ./Ejercicio02-150-az.sh
elif [ 2 -eq $num ]; then
    ./Ejercicio02-Ord.sh
else 
    exit 1
fi   