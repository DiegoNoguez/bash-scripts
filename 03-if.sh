#!/bin/bash

function funcionCondicion () {
    #programa
    return 5 #1 al 255 es error debido que para que la funcion sea verdadera requiere de un 0 

}

if funcionCondicion; then
    echo "La funcion es Verdadera"
elif [ 3 -eq 3 ];then
    echo "3 es igual a 3" #para igualar
else 
    echo "La funcion es falsa"
fi 

#el de la izquierda es mayor que derecha  -gt
#el de la izquierda es menor que el de la drecha -lt 
#iguales -eq
#mayor o igual                                    -ge
#menor igual                                      -le


if [ 3 -gt 2 ]; then #entre corchetes debe haber espacio 
    echo "El if 1 es verdadero"
fi

if [ 0 -lt 3 ]; then
    echo "El if 2 es verdadero"
fi 

if [ 3 -eq 3 ]; then
    echo "El if 3 es verdadero"
fi

if [ 3 -ge 3 ]; then 
    echo "El if 4 es verdadero"
fi 

if [ 1 -le 2 ]; then 
    echo "El if 5 es verdadero"
fi

#visualizar si un archivo existe 

if [ -e "./archivo1.txt" ]; then
    echo "El archivo si existe en la ruta"
fi

#exite y es un directorio 

if [ -d ~/ ]; then
    echo "La ruta home es un directorio"
fi 

#un archivo es mas nuevo que otro 
if [ "archivo2.txt" -nt "archivo1.txt" ]; then #se esta comparando dos archivos
    echo "El archvip 2 es mas nuevo que el archivo1"
fi 


#el archivo 2 es mas viejo
if [ "archivo1.txt" -ot "archivo2.txt" ]; then 
    echo "El archivo1 es mas viejo que el archivo2 "
fi 
