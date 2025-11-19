#!/bin/bash

dispositivos=()  # Array para almacenar los dispositivos
puntos_montaje=()  # Array para almacenar los puntos de montaje

# Función para listar los dispositivos conectados
listar_dispositivos() {
    echo "Lista de dispositivos conectados:"
    echo "---------------------------------"
    dispositivos=()  # Reiniciamos el array
    puntos_montaje=()  # Reiniciamos el array
    contador=1  # Inicializamos el contador

    while IFS= read -r line; do
        nombre=$(echo "$line" | awk '{print $1}' | sed 's/^└─//')
        punto_montaje=$(echo "$line" | awk '{if (NF==3) print $2; else print "Sin punto de montaje"}')
        tamano=$(echo "$line" | awk '{print $NF}')

        dispositivos+=("$nombre")
        puntos_montaje+=("$punto_montaje")

        echo "$contador) Dispositivo: /dev/$nombre"
        echo "   Punto de montaje: $punto_montaje"
        echo "   Tamaño: $tamano"
        echo "---------------------------------"

        contador=$((contador + 1))
    done < <(lsblk -n -o NAME,MOUNTPOINT,SIZE)
}

# Función para montar un dispositivo
montar_dispositivo() {
    read -p "Ingrese el número del dispositivo a montar: " num
    if [[ $num -le 0 || $num -gt ${#dispositivos[@]} ]]; then
        echo "Número de dispositivo inválido. Seleccione un número de la lista."
        return
    fi

    dispositivo=${dispositivos[$((num - 1))]}

    punto_montaje_actual=${puntos_montaje[$((num - 1))]}
    if [ "$punto_montaje_actual" != "Sin punto de montaje" ]; then
        echo "El dispositivo ya está montado en $punto_montaje_actual."
        return
    fi

    punto_montaje="/mnt/$dispositivo"
    read -p "Ingrese el directorio donde desea montar ($punto_montaje por defecto): " input_montaje
    if [ -n "$input_montaje" ]; then
        punto_montaje="$input_montaje"
    fi

    if [ ! -d "$punto_montaje" ]; then
        echo "El directorio $punto_montaje no existe. Creándolo..."
        sudo mkdir -p "$punto_montaje"
    fi

    echo "Montando /dev/$dispositivo en $punto_montaje..."
    sudo mount "/dev/$dispositivo" "$punto_montaje"
    if [ $? -eq 0 ]; then
        echo "Dispositivo montado correctamente en $punto_montaje."
    else
        echo "Error al montar el dispositivo."
    fi
}

# Función para desmontar un dispositivo
desmontar_dispositivo() {
    read -p "Ingrese el número del dispositivo a desmontar: " num
    if [[ $num -le 0 || $num -gt ${#dispositivos[@]} ]]; then
        echo "Número de dispositivo inválido. Seleccione un número de la lista."
        return
    fi

    dispositivo=${dispositivos[$((num - 1))]}
    punto_montaje=${puntos_montaje[$((num - 1))]}

    if [ -z "$punto_montaje" ] || [ "$punto_montaje" = "Sin punto de montaje" ]; then
        echo "El dispositivo no está montado."
        return
    fi

    echo "Desmontando /dev/$dispositivo desde $punto_montaje..."
    sudo umount "$punto_montaje"
    if [ $? -eq 0 ]; then
        echo "Dispositivo desmontado correctamente."
    else
        echo "Error al desmontar el dispositivo."
    fi
}

# Función pinfo para mostrar información de un proceso


# Menú principal
while true; do
    echo "Menú de opciones:"
    echo "1) Listar dispositivos"
    echo "2) Montar dispositivo"
    echo "3) Desmontar dispositivo"
    echo "4) Salir"
    read -p "Seleccione una opción: " opcion

    case $opcion in
        1)
            listar_dispositivos
            ;;
        2)
            listar_dispositivos
            montar_dispositivo
            ;;
        3)
            listar_dispositivos
            desmontar_dispositivo
            ;;
        4)
            echo "Saliendo..."
            break
            ;;
            
        *)
            echo "Opción no válida."
            ;;
    esac
done