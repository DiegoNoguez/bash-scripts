import os
import subprocess

def listar_dispositivos():
    """Lista los dispositivos conectados con su punto de montaje, tamaño y sistema de archivos."""
    print("\nDispositivos de almacenamiento disponibles:")
    try:
        # Usar lsblk para listar dispositivos, excluyendo los de tipo loop
        subprocess.run(["lsblk", "-o", "NAME,SIZE,FSTYPE,MOUNTPOINT", "--exclude", "7"], check=True)
    except subprocess.CalledProcessError:
        print("Error al listar los dispositivos.")

def verificar_sistema_archivos(dispositivo):
    """Verifica si un dispositivo tiene un sistema de archivos válido."""
    try:
        salida = subprocess.check_output(["blkid", dispositivo], text=True)
        if "TYPE=" in salida:
            return True
        else:
            return False
    except subprocess.CalledProcessError:
        return False

def montar_dispositivo():
    """Permite montar un dispositivo especificado por el usuario."""
    dispositivo = input("\nIngrese el nombre del dispositivo a montar (ejem. /dev/sdb1): ")
    punto_montaje = input("Ingrese el punto de montaje (ejem. /mnt/dispositivo): ")

    # Verificar si el dispositivo ingresado existe
    if not os.path.exists(dispositivo):
        print(f"El dispositivo {dispositivo} no existe. Verifica el nombre.")
        return

    # Verificar si el dispositivo tiene un sistema de archivos
    if not verificar_sistema_archivos(dispositivo):
        print(f"El dispositivo {dispositivo} no tiene un sistema de archivos válido o no es una partición.")
        return

    # Verificar si el punto de montaje ya existe; si no, crearlo
    if not os.path.exists(punto_montaje):
        try:
            os.makedirs(punto_montaje)
            print(f"El punto de montaje {punto_montaje} ha sido creado.")
        except OSError as e:
            print(f"Error al crear el punto de montaje: {e}")
            return

    try:
        # Intentar montar el dispositivo
        subprocess.run(["sudo", "mount", dispositivo, punto_montaje], check=True)
        print(f"El dispositivo {dispositivo} ha sido montado en {punto_montaje}.")
    except subprocess.CalledProcessError as e:
        print(f"Error al montar {dispositivo} en {punto_montaje}: {e}")

def desmontar_dispositivo():
    """Desmontar un dispositivo especificado por el usuario."""
    dispositivo = input("\nIngrese el nombre del dispositivo a desmontar (ej. /dev/sdb1): ")

    # Verificar si el dispositivo está montado
    try:
        subprocess.run(["sudo", "umount", dispositivo], check=True)
        print(f"El dispositivo {dispositivo} ha sido desmontado.")
    except subprocess.CalledProcessError as e:
        print(f"Error al desmontar {dispositivo}: {e}")

def menu():
    """Muestra el menú de opciones al usuario."""
    while True:
        print("\n--- Menú de Gestión de Dispositivos ---")
        print("1. Listar dispositivos conectados")
        print("2. Montar un dispositivo")
        print("3. Desmontar un dispositivo")
        print("4. Salir")
        
        opcion = input("Seleccione una opción (1/2/3/4): ")
        
        if opcion == "1":
            listar_dispositivos()
        elif opcion == "2":
            montar_dispositivo()
        elif opcion == "3":
            desmontar_dispositivo()
        elif opcion == "4":
            print("Saliendo...")
            break
        else:
            print("Opción no válida. Por favor, seleccione una opción válida.")

if __name__ == "__main__":
    menu()
