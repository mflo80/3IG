#!/bin/bash

# Creado por Marcelo Florio
# 21 de abril de 2020

# Ejercicio 6: Escribir un script que genere un backup comprimido en formato TAR-GZIP del
# directorio de trabajo /home/myusuario cada 5 minutos asignandole el nombre de backup-hora
# de generacion.tar.gz

# Para que genere el backup cada 5 minutos hay que utilizar el comando crontab -e y
# agregar la siguiente linea: */5 * * * * sh ruta_script/nombre_script.sh
# luego de guardar y cerrar el editor, se debe reiniciar el servicio: service con restart


function error {
  echo
  echo "No existe la carpeta del usuario ingresado"
}

function respaldar {
  echo "Respaldando carpeta de trabajo del usuario" $1
  usuario=$1
  hora=$(date +%H%M) # Captura la hora y minuto actual
  echo "Comprimiendo espere por favor..."
  tar -czf backup-$usuario-$hora.tar.gz /home/$usuario/
    # Se mueve el archivo generado a la carpeta de respaldos, ya que sino queda dentro de la
    # carpeta del usuario y al generarse otro respaldo, el archivo va a quedar dentro del nuevo
    # backup y asi sucesivamente, generaldose cada vez un archivo de mayor tamanio innecesario
    # En caso de crear una nueva carpeta de destino para almacenar los backup, el usuario
    # tiene que tener los privilegios para escribir en ella.
  sleep 2
  mv -f backup-$usuario-$hora.tar.gz /home/backup/backup-$usuario-$hora.tar.gz
  if [ -f /home/backup/backup-$usuario-$hora.tar.gz ]; then
    echo "Respaldo finalizado con exito"
  else
    if [ -f backup-$usuario-$hora.tar.gz ]; then
     rm backup-$usuario-$hora.tar.gz
    fi
    echo "Error Codigo:" $? "No se realizo el respaldo, intente nuevamente"
  fi
}

# Funcion que verifica si existe la carpeta donde se van a guardar los respaldos
# en caso de no existir la crea, de lo contrario generara error y se detendra el proceso
function verificar_carpeta_backup {
  cd /home/backup &> /dev/null
  error=$(echo $?)
  if [ $error -eq 1 ]; then
    echo "No se encontro la carpeta de almacenamiento de los respaldo"
    sleep 1
    echo "Creando la carpeta, espere por favor"
    sleep 1
    sudo mkdir /home/backup/
    sudo chmod 777 /home/backup/
    error=$(echo $?)
    if [ $error -eq 1 ]; then
      echo "Error al crear la carpeta, no se pudo realizar el respaldo"
      echo "Comuniquese con el administrador"
      sleep 1
      exit
    else
      echo "Carpeta creada con exito"
    fi
  elif [ $error -eq 0 ]; then
    echo "Iniciando proceso de respaldo, espere por favor"
    sleep 2
  else
    echo "Error fatal. Codigo No:" $?
    exit 1
  fi
}

# Funcion que verifica que exista la carpeta home del usuario ingresado
# en caso de no existir genera un codigo de error
function verificar_usuario {
  if [ -d /home/$1 ]; then
    respaldar $1
    sleep 2
  else
    /home/$1 &> /dev/null
    echo "Error Codigo:" $? "- No existe una carpeta con el nombre del usuario ingresado"
  fi
}

function menu {
  PS3="Seleccione una opcion: "
  OPCIONES=("Ingresar" "Menu Principal" "Salir")
  select option in "${OPCIONES[@]}"; do
    if [ "$option" = "Ingresar" ]; then
      echo
      read -p "Usuario: " nombre
      verificar_carpeta_backup
      verificar_usuario $nombre
      break
    elif [ "$option" = "Menu Principal" ]; then
      exit
    elif [ "$option" = "Salir" ]; then
      exit 1
    else
      echo
      echo "Opcion no valida"
      break
    fi
  done
}

while true; do
  echo
  echo "RESPALDAR LA CARPETA HOME DE UN USUARIO"
  menu
done
