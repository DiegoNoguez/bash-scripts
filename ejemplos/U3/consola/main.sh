#! /bin/bash

source .bashrc

#limpiar la cosonla
clear

#inicio de un ciclo_interprete inicializado 
while true;do 
    route=$(pwd)
    read -p "$route >> " command
    eval $command
done
