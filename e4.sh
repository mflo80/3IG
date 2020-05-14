#!/bin/bash

# Creado por Marcelo Florio
# 20 de abril de 2020

# Ejercicio 4: Escribir un script que lo salude con su nombre completo cada vez
# que ingrese en la consola tty1 como usuario creado con su nombre

function saludar {
  usuario=$(whoami)
  rutaterminal=$(tty)
  terminal=$(echo $rutaterminal | cut -d "/" -f 3) # Extrae solo la terminal de la ruta
                                                 # obtenida al ejecutar el comando tty
  # Otra opcion que se podria hacer tambien es, omitir esta linea, y ya directo comparar en el if
  # si la variable rutaterminal es igual a /var/tty1

  echo

  if [ $usuario = "mflorio" ] && [ $terminal = "tty1" ]; then
    echo "Bienvenido Marcelo Fabian Florio Gonzalez, has iniciado sesion en la terminal > tty1"
  elif [ $usuario = "root" ]; then
    echo "Hola humano, has iniciado sesion como root en la terminal >" $terminal
  else
    echo "Bienvenido humano, has iniciado sesion en la terminal >" $terminal
  fi

  sleep 3
  exit
}

saludar

