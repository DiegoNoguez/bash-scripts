#!/bin/bash
#Scritp que genere archivos del 1 al 50 con extension de la a hasta la z
if [  -d /run/media/springy/Data/ARCHIVOS_DOC/VScode/linux/OS/programasU2/ejercicios22oct/1-50 ]; then
    rm -rf 1-50 #Si exitse la carpeta lo elimina 
    mkdir 1-50
    cd 1-50
    for numero in {1..50}; do
        mkdir $numero
        cd $numero
        for letra in {a..z}; do
            touch $numero.$letra 
        done 
        cd ..
    done
    echo "Scripts generados exitosamente"
else 
    mkdir 1-50
    cd 1-50
    for numero in {1..50}; do
        mkdir $numero
        cd $numero
        for letra in {a..z}; do
            touch $numero.$letra 
        done 
        cd ..
    done
    echo "Scripts generados correctamente"
fi 

