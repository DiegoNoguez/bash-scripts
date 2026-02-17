#!/bin/bash 
# Este es un script para el control de Xampp en un sistema Linux
# 
# Este script es capaz de funciona en cualquier distro solo teniendo 
# en cuenta que la ruta debe ser de /opt/lampp/

# Variables #
menu=" 1)Encender xampp\n 2)Apagar xampp\n 3)Estado del servicio de xampp\n 4)Reiniciar servicio\n 5)Salir."

# Codigo General
while true; do
    figlet "Bienvenido al gestor de  XAMPP" -c -t -f shadow
    echo "Qué es lo que deseas hacer con Xampp el día de hoy:"
    echo -e "$menu" 
    read -p "Ingresa tu opción a realizar: " opcion
    #echo $opcion  # verificacion del recibimiento de los datos. 
    case "$opcion" in 
        1)
            echo "Iniciando xampp..."
            sudo /opt/lampp/lampp start  
            echo "Servicio iniciado correctamente..."
            sleep 5 
            echo "Regresando al menu .."
            sleep 2  
            clear
            ;;
        2)
            echo "Apagando xampp"
            sudo /opt/lampp/lampp stop
            echo "Servicio apagado correctamente....."
            sleep 2
            echo "Regresando..." 
            sleep 1
            clear 
            ;;
        3)
            echo "Revisando status del servicio..."
            sudo /opt/lampp/lampp status
            sleep 6
            clear
            ;;
        4)
            echo "Reiniciando el servicio de Xampp"
            sleep 5
            sudo /opt/lampp/lampp restart
            echo "Servicio reiniciado con exito"
            sleep 2
            echo "Regresando al menu ..."
            sleep 2 
            clear 
            ;;
        5)
            echo "Saliendo del script..."
            sleep 5
            echo "Regresando al Script maestro..."
            sleep 5
            clear
            break # salida dle bucle.
            ;;
            
        *)
            echo "Opción no valida"
            opcion=0
            echo -e "\n" 
            ;;
    esac 
done