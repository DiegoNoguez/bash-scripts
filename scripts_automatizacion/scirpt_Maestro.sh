#!/bin/bash 
# En este script es un menú general de donde se gestionaran 
# otros scripts del sistema con solo ejecutar el alias de este
# script en mi terminal. 

# Varibales
menu=" 1)Gestión de Xampp\n 5)Salir"
tiempo_Dormir=5

# Lógica
echo "Ingresando al directorio General.."
sleep 3
cd /home/SpringyB6/Documents/bash-scripts/scripts_automatizacion/

while true; do 
    figlet "Menu Maestro" 
    echo "Selecciona el servicio que deseas iniciar dentro del menu de opciones"
    echo -e "$menu"
    read -p "Opcion-> " opcion_Mast
    case "$opcion_Mast" in
        1)
            echo "Ejecutando el servicio..."
            sleep $tiempo_Dormir
            clear
            ./onXampp.sh
            ;;
        5) 
            echo "Saliendo del script..."
            sleep $tiempo_Dormir
            clear 
            break
            ;;
        *)
            echo "Operación invalida"
            ;;
            
    esac 
done