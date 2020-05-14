#!/bin/bash

# Creado por Marcelo Florio
# 20 de abril de 2020

# Ejercicio 2: Escribir un script que al pasarle por argumento un archivo
# o directorio, devuelve el tamanio en MB

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

function tamanio {
  texto=$(du -cshkx $1) # Carga en la variable texto lo capturado por el comando du
                        # del archivo o carpeta ingresada. El valor lo captura en KB
                        # ya que es mas exacto que en el resto de las medidas
  valor=$(echo $texto | cut -d ' ' -f 1) # De la cadena texto extrae solo el tamanio
  total=$(echo "scale=4; $valor / 1024" | bc) # Convierte el tamanio de KB a MB
  if [ `echo "$total < 1" | bc` -eq 1 ]; then
    echo $1 "0"$total "MB" # Si el total es menor que 1, se le ingresa un cero a la
                           # izquierda, ya que lo muestra sino como .00012
  else
    total=$(echo "scale=2; $valor / 1024" | bc)
    echo $1 $total "MB"
  fi
}

function verificar {
  if [ -z $1 ]; then
    vacio
    continuar
  elif [ -d $1 ] || [ -f $1 ]; then
    tamanio $1
    continuar
  else
    error "archivo o directorio"
    continuar
  fi
}

function menu {
 PS3="Seleccione una opcion: "
 OPCIONES=("Ingresar"
           "Menu Principal"
           "Salir")
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
   echo "MUESTRA EL TAMANIO DE UN ARCHIVO O DIRECTORIO EN MB"
   menu
done
