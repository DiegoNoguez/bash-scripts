#!/bin/bash
if [ -d /run/media/springy/Data/ARCHIVOS_DOC/VScode/linux/OS/programasU2/scripts-automaticos ]; then
    rm -rf scripts-automaticos
    mkdir scripts-automaticos
    echo "Existe la carpeta"
    cd ./scripts-automaticos
    for numero in {1..500}; do
        touch "script-$numero.sh"
        echo "echo "Hola desde el archivo$numero"">>script-$numero.sh
    done 

else
    echo "La carpeta no existe"
    mkdir scripts-automaticos
    cd ./scripts-automaticos
    for numero in {1..500}; do
        touch "script-$numero.sh"
        echo "echo "Hola desde el archivo$numero"">>script-$numero.sh
    done 
fi 


