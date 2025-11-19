import os
import subprocess

def listar_dispositivos():
    """Lista los dispositivos conectados con su punto de montaje y tamaño."""
    print("\nDispositivos de almacenamiento disponibles:")
    os.system("lsblk -o NAME,SIZE,MOUNTPOINT | grep -v 'loop'")

def montar_dispositivo():
    """Permite montar un dispositivo especificado por el usuario."""
    dispositivo = input("\nIngrese el nombre del dispositivo a montar (ejem. /dev/sdb1): ")
    punto_montaje = input("Ingrese el punto de montaje (ejem. /mnt/dispositivo): ")

    # Verificar si el punto de montaje ya existe, si no, crear
    if not os.path.exists(punto_montaje):
        os.makedirs(punto_montaje)

    try:
        # Montar el dispositivo
        subprocess.run(["sudo", "mount", dispositivo, punto_montaje], check=True)
        print(f"El dispositivo {dispositivo} ha sido montado en {punto_montaje}.")
    except subprocess.CalledProcessError:
        print(f"Error al montar {dispositivo} en {punto_montaje}.")

def desmontar_dispositivo():
    """Desmontar un dispositivo especificado por el usuario."""
    dispositivo = input("\nIngrese el nombre del dispositivo a desmontar (ej. /dev/sdb1): ")

    try:
        # Desmontar el dispositivo
        subprocess.run(["sudo", "umount", dispositivo], check=True)
        print(f"El dispositivo {dispositivo} ha sido desmontado.")
    except subprocess.CalledProcessError:
        print(f"Error al desmontar {dispositivo}.")

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
