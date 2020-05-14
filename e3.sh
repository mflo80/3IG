#!/bin/bash

# Creado por Marcelo Florio
# 20 de abril de 2020

# Ejercicio 3: Escribir un script que al no pasarle argumentos, sugiere al usuario
# cuales son las posibles opciones para su ejecucion

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
  echo "No existe un $1 con el nombre ingresado"
}

function vacio {
  echo "Campo vacio, no ha ingresado el dato solictado"
}

function verificar {
  if [ -z $1 ]; then
    vacio
    continuar
  elif [ -d $1 ]; then
    ls -lcakh $1
    continuar
  elif [ -f $1 ]; then
    ls -lkh $1
    continuar
  else
    error "archivo o directorio"
    continuar
  fi
}

function menu {
 PS3="Seleccione una opcion: "
 OPCIONES=("Ingresar" "Menu Principal" "Salir")
 select option in "${OPCIONES[@]}"; do
   if [ "$option" = "Ingresar" ]; then
      echo
      read -p "Ingrese el nombre del archivo o directorio: " nombre
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
   echo "VER LAS PROPIEDADES DE UN ARCHIVO O EL CONTENIDO DE UN DIRECTORIO"
   menu
done
