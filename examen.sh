#! /bin/bash

Archivo= /var/lib/todolist/todolist.tfl
#Vereificacion de si se etsa ejecutando como administradpr 
if [[ $EUID -eq 0 ]]; then
    echo "EL script no se puede ejecutar debido a la falta de permisos"
    exit 1
fi

#creacion o iniciar el archivo
iniciarArch() {
    if [ ! -f "$Archivo" ]; then
        echo "El archivo $Archivo no existe, por lo tanto se creara"
        sudo mkdir -p /var/lib/todolist
        sudo touch "$Archivo"
        sudo chmod 666 "$Archivo"
        echo "Archivo creado"
    fi 
}


#Creacion de la tabla para despues actualizar con los que agrege el usuario.
declare -a tabla # creacion de array 
#impresion de la tabla 
imprimir_tabla() {
    if [ ${#tabla[@]} -eq 0 ]; then 
        echo "No hay datos en la tabla"
        return 0
    fi 

    #impresion de la cabecera de la tabla
    echo "--------------------------------------------"
    echo "| ID   | Nombre          | Status   |"
    echo "--------------------------------------------"

    #En base al array se mostran los registros almacenados
    for registro in "${tabla[@]}"; do
        IFS=',' read -r id nombre status <<< "$registro"
        printf "| %-4s | %-15s | %-8s |\n" "$id" "$nombre" "$status"
    done
    echo "--------------------------------------------"
}
#agregar fila a la tabla
agregar_Datos() {
    #asignacio de id apartir del array 
    if [ ${#tabla[@]} -eq 0 ]; then
        nuevo_id=1
    else
        ultimo_id=$(echo "${tabla[-1]}" | cut -d',' -f1)
        nuevo_id=$((ultimo_id + 1)) 
    fi 

    #lectura de datos ingresados por el usuario
    read -p "Ingrese el nombre: " nombre
    read -p "Ingrese el status: " status 
    #validar datos
    if [[ -z "$nombre" || -z "$status" ]]; then
        echo "Llena todos los campos por favor"
        return 1
    fi 

    #agregar los datos a la tabla/array 
    tabla+=("$nuevo_id","$nombre","$status")
    echo "Se agrego correctamente la nueva tarea"
} 

#eliminar o modificar tareas

#Impresion del menu 
iniciarArch
Archivo= /var/lib/todolist/todolist.tfl
while true; do 
    echo "TAREAS A REALIZAR"
    echo "Bienvenido"
    echo -e "\033[36m1--Crear tarea\033[36m"
    echo "2--Mostrar tarea"
    echo "3--Eliminar tarea"
    echo -e "\033[36m4--Salir\033[0m"

    read -p "Selecciona la opcion a realizar: " opcion
    #logica.
    case "$opcion" in
        1)
            agregar_Datos
        ;;
        2)
            imprimir_tabla
        ;;
        3)
            
        ;;
        4)
        echo "Adios"
        exit 1
        ;;
    esac
done