#!/bin/bash

function salir {
   if [ $1 -eq 1 ]; then
     echo
     exit
   fi
}

function menu {
PS3="Seleccione una opcion: "
OPCIONES=("Ejercicio 1" "Ejercicio 2" "Ejercicio 3" "Ejercicio 4" "Ejercicio 5" "Ejercicio 6" "Salir")
select opcion in "${OPCIONES[@]}"; do
   if [ "$opcion" = "Ejercicio 1" ]; then
     ./e1.sh
     salir $?
     break
   elif [ "$opcion" = "Ejercicio 2" ]; then
     ./e2.sh
     salir $?
     break
   elif [ "$opcion" = "Ejercicio 3" ]; then
     ./e3.sh
     salir $?
     break
   elif [ "$opcion" = "Ejercicio 4" ]; then
     ./e4.sh
     salir $?
     break
   elif [ "$opcion" = "Ejercicio 5" ]; then
     ./e5.sh
     salir $?
     break
   elif [ "$opcion" = "Ejercicio 6" ]; then
     ./e6.sh
     salir $?
     break
   elif [ "$opcion" = "Salir" ]; then
     exit
   else
     echo
     echo "Opcion no valida"
     sleep 1
     break
  fi
done
}

while true; do
  echo
  echo "MENU PRINCIPAL"
  menu
done
