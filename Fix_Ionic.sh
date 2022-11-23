#!/bin/sh
# -*- ENCODING: UTF-8 -*-

#Ajustando IONIC
# Esto resuelve el problema de: 
#
#   Te estás topando con un límite de kernel con tus observadores de inotify. Puede ejecutar esto para arreglarlo para el arranque actual: 
#   **Insertar el nuevo valor en la configuración del sistema**
#
#   echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p
#
#   **verificar que se aplicó un nuevo valor**
#   cat /proc/sys/fs/inotify/max_user_watches

fijar_problema_ionic(){
    echo
    echo ">>> Ajustando Valores Para: ionic serve"
    echo
    echo "cat /proc/sys/fs/inotify/max_user_watches"
    cat /proc/sys/fs/inotify/max_user_watches
    echo
    echo "sudo sysctl -p"
    sudo sysctl -p
    echo ">>> Presione una tecla para continuar..."
}

fijar_problema_ionic
