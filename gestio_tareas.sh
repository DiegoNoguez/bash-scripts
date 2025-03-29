#!/bin/bash

Archivo="/var/lib/todolist/todolist.tfl"  
# Verificación de si se está ejecutando como administrador 
if [[ $EUID -eq 0 ]]; then
    echo "El script no se puede ejecutar debido a la falta de permisos"
    exit 1
fi

# Creación o iniciar el archivo
iniciarArch() {
    if [ ! -f "$Archivo" ]; then
        echo "El archivo $Archivo no existe, por lo tanto se creará"
        sudo mkdir -p /var/lib/todolist
        sudo touch "$Archivo"
        sudo chmod 666 "$Archivo"
        echo "Archivo creado"
    fi 
}

# Creación de la tabla para después actualizar con los que agregue el usuario.
declare -a tabla  # Creación de array
# Impresión de la tabla
imprimir_tabla() {
    if [ ${#tabla[@]} -eq 0 ]; then 
        echo "No hay datos en la tabla"
        return 0
    fi 

    # Impresión de la cabecera de la tabla
    echo "--------------------------------------------"
    echo "| ID   | Nombre          | Status   |"
    echo "--------------------------------------------"

    # En base al array se muestran los registros almacenados
    for registro in "${tabla[@]}"; do
        IFS=',' read -r id nombre status <<< "$registro"
        printf "| %-4s | %-15s | %-8s |\n" "$id" "$nombre" "$status"
    done
    echo "--------------------------------------------"
}

# Agregar fila a la tabla
agregar_Datos() {
    # Asignación de id a partir del array 
    if [ ${#tabla[@]} -eq 0 ]; then
        nuevo_id=1
    else
        ultimo_id=$(echo "${tabla[-1]}" | cut -d',' -f1)
        nuevo_id=$((ultimo_id + 1)) 
    fi 

    # Lectura de datos ingresados por el usuario
    read -p "Ingrese el nombre: " nombre
    read -p "Ingrese el status: " status 
    # Validar datos
    if [[ -z "$nombre" || -z "$status" ]]; then
        echo "Llena todos los campos por favor"
        return 1
    fi 

    # Agregar los datos a la tabla/array 
    tabla+=("$nuevo_id,$nombre,$status")
    echo "Se agregó correctamente la nueva tarea"
} 

# Eliminar tarea por ID
eliminar_tarea() {
    read -p "Ingrese el ID de la tarea a eliminar: " id_tarea
    # Buscamos si existe la tarea con ese ID
    tarea_encontrada=false
    for i in "${!tabla[@]}"; do
        IFS=',' read -r id nombre status <<< "${tabla[i]}"
        if [ "$id" -eq "$id_tarea" ]; then
            tarea_encontrada=true
            unset 'tabla[i]'  # Eliminar la tarea del array
            echo "Tarea con ID $id_tarea eliminada correctamente"
            break
        fi
    done

    if ! $tarea_encontrada; then
        echo "No se encontró ninguna tarea con ese ID."
    fi
}

# Modificar tarea
modificar_tarea() {
    read -p "Ingrese el ID de la tarea a modificar: " id_tarea
    tarea_encontrada=false
    for i in "${!tabla[@]}"; do
        IFS=',' read -r id nombre status <<< "${tabla[i]}"
        if [ "$id" -eq "$id_tarea" ]; then
            tarea_encontrada=true
            echo "Tarea encontrada: ID $id, Nombre: $nombre, Status: $status"
            
            read -p "Nuevo nombre (deje en blanco para no modificar): " nuevo_nombre
            read -p "Nuevo status (deje en blanco para no modificar): " nuevo_status

            # Si no se proporcionó nuevo nombre, mantiene el nombre original
            if [ -n "$nuevo_nombre" ]; then
                nombre=$nuevo_nombre
            fi
            # Si no se proporcionó nuevo status, mantiene el status original
            if [ -n "$nuevo_status" ]; then
                status=$nuevo_status
            fi

            # Actualizamos la tarea modificada en la tabla
            tabla[$i]="$id,$nombre,$status"
            echo "Tarea modificada correctamente"
            break
        fi
    done

    if ! $tarea_encontrada; then
        echo "No se encontró ninguna tarea con ese ID."
    fi
}

# Impresión del menú 
iniciarArch
Archivo="/var/lib/todolist/todolist.tfl"  # Corregí la asignación de la variable Archivo
while true; do 
    echo ""
    echo "Bienvenido"
    echo -e "\033[36m1--Crear tarea\033[36m"
    echo "2--Mostrar tareas"
    echo "3--Eliminar tarea"
    echo "4--Modificar tarea"
    echo -e "\033[36m5--Salir\033[0m"

    read -p "Selecciona la opción a realizar: " opcion
    # Lógica
    case "$opcion" in
        1)
            agregar_Datos
        ;;
        2)
            imprimir_tabla
        ;;
        3)
            eliminar_tarea
        ;;
        4)
            modificar_tarea
        ;;
        5)
            echo "Adiós"
            exit 1
        ;;
        *)
            echo "Opción no válida. Intenta de nuevo."
        ;;
    esac
done
