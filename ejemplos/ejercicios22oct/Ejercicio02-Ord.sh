#! /bin/bash

#Script que ordene los archivos del script 1 en carpetas de la a a lz segun la extension
if [ -d /run/media/springy/Data/ARCHIVOS_DOC/VScode/linux/OS/programasU2/ejercicios22oct/ordlet ]; then 
    rm -rf ordlet   #si existe la carpeta la va a eliminar 
fi 
mkdir ordlet   #crea una carpeta donde estaran todas las demas carpetad del abc 
for letra in {a..z}; do
    cd ordlet   #entra a la carpeta 
    mkdir $letra #crea la carpeta de la respectiva letra 
    cd ..
    for numero in {1..50}; do
    cd 1-50      #Entra a la carpeta que se genero del script anterior 
    cd $numero 
    echo "Estoy en la carpeta $numero"
    ls | grep "\.$letra$" #filtrar la terminacion especifica del la letra 
    mv "$numero.$letra"  /run/media/springy/Data/ARCHIVOS_DOC/VScode/linux/OS/programasU2/ejercicios22oct/ordlet/$letra
    cd ..
    cd ..
    done 
done 