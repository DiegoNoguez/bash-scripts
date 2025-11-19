#!/bin/bash

for (( i=0; i<=10; i++ )); do
    echo "Hola desde dentro de un for $i"
done
#ejecucion de listas 
for numero in 1 2 3 4 5 6 7 8; do
    echo "numero: $numero"
done

for numero in {0..25}; do #se define la lista que deseamos
    echo $numero
done
#
for letra in {a..c}; do #se define la lista que deseamos puede usar minuscula o mayuscula ambas tiene que estar en lo mismo
    echo $letra 
done

for archivo in /usr/bin/*zip; do
    echo $archivo
done