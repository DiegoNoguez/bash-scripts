#! /bin/bash
function pinfo () {
    aplicacion="$1"
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
}
#este seria el interprete de comandos creado o diseñado por uno mismo 

while true; do
    #ingresa el comando 
    read -p "$USER> " command 

    if [[ $command == "salir" ]]; then
        exit 0   #sale del programa al
    elif [[ "$command" == "ge" ]]; then 
        cd ejercicios22oct
        ./Ejercicio02-150-az.sh
    elif [[ "$command" == "oa" ]]; then 
        cd ejercicios22oct
        ./Ejercicio02-Ord.sh
    elif [[ "$command" =~ ^pinfo\ (.+)$ ]]; then
        aplicacion="${BASH_REMATCH[1]}"  # Extrae el nombre de la aplicación
        pinfo "$aplicacion" 

    elif [[ "$command" == "menu" ]]; then
       #Accion para ejecutar mi codigo de python menuDispo
       #codigo_python="menuMonta.py"
       ##realizar vereficacion que el codigo y archivo .py existe 
       #if [[ -f "$codigo_python" ]]; then 
       #     python3 "$codigo_python"
       # else
       #     echo "El codigo de python es inexistente" 
       # fi
       ./monDemont.sh
    else
        eval "$command"
    fi 
done