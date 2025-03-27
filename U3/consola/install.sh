#! /bin/bash
##tarea es hacer que cuando se veuelva a ejecutar verificque si esta no hcaer nada y si no esta copiarlo 

#Archivo de instalación de apps 
#Ejecuta el archivo con permisos de adminsitrador
#chmod +x install.sh
#Y el comando bash install.sh 

#Pasos
#Paso 1: Copiar archivos a carpeta de instalacion
echo "Desempaquetando los archivos de la aplicacion"
sudo mkdir -p /opt/terminal1
sudo cp -r ./* /opt/terminal1
sudo cp ./.bashrc /opt/terminal1
sleep 3

#Paso 2: Crear la llamada del comando en el archivo ~/.bashrc
echo "Agregando el comando a la terminal de bash"
CMD_ALIAS1="function terminal1 (){"
CMD_ALIAS2=" bash /opt/terminal1/main.sh "   #ESTE COMANDO EN UNO SOLO 
CMD_ALIAS3="}"

#EN EL ARCHIVO BASHRC ESCRIBIR LOS SIGUIENETES COMANDOS 

echo $CMD_ALIAS1 >> ~/.bashrc
echo $CMD_ALIAS2 >> ~/.bashrc
echo $CMD_ALIAS3 >> ~/.bashrc
sleep 2

echo "Reinicia tu consola para aplicar los cambios y usar el comando 'terminal1'"
echo "o escribe 'source ~/.bashrc'"