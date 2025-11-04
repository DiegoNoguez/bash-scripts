#!/bin/bash

# Script para listar los dispositivos conectados con nombre, tamaño y número de dispositivo programado en bash o shell 

echo "Listando los  dispositivos conectados..."

# Mostrar los dispositivos de almacenamiento (discos duros, pendrives, etc.) con el nombre, tamaño y número de dispositivo
echo -e "\nDispositivos de almacenamiento:"
lsblk -o NAME,SIZE,MOUNTPOINT | grep -v 'loop'  # Filtra dispositivos 'loop' si no los quieres mostrar

# Mostrar dispositivos USB
echo -e "\nDispositivos USB conectados:"
lsusb | awk '{print $6, $7, $8, $9}' # Muestra el ID del dispositivo USB

# Mostrar las particiones montadas (nombre, tamaño y punto de montaje)
echo -e "\nParticiones montadas:"
df -h --output=source,size,target | tail -n +2 # Muestra el nombre, tamaño y punto de montaje

