#!/bin/bash

# Creado por Marcelo Florio
# 20 de abril de 2020

# Ejercicio 5: Escribir un script que puede mostrar informacion de un comando
# al ejercutar dicho script y pasar como parametro el comando

function continuar {
 while true; do
   echo
   read -p "Presione la tecla 0 para continuar: " tecla
   if [ $tecla -ne 0 ]; then
     echo "Opcion no valida"
   else
     break
   fi
 done
}

function error {
  echo "Demasiados parametros"
}

function vacio {
  echo "Campo vacio, no ha ingresado el dato solictado"
}

function verificar {
  if [ -z $1 ]; then
    vacio
    continuar
  elif [ $2 ]; then
    error
    continuar
  else
    man $1
    echo
  fi
}

function menu {
 PS3="Seleccione una opcion: "
 OPCIONES=("Ver manual" "Menu Principal" "Salir")
 select option in "${OPCIONES[@]}"; do
   if [ "$option" = "Ver manual" ]; then
      echo
      read -p "Ingrese el nombre del comando: " nombre
      verificar $nombre
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
   echo "VER MANUAL DE AYUDA DE UN COMANDO"
   menu
done
