#!/bin/sh
# -*- ENCODING: UTF-8 -*-
#This script required install dialog-1:1.3_20220526-1
#For Manjaro => sudo pacman -S dialog

ajustar_swap_v2()
{
	local opcion_valida="false"
	local consultar_swap=`cat /proc/sys/vm/swappiness`
	local valor_swap=""
	while [ $opcion_valida = "false" ]
	do
	  clear
	  valor_swap=$(dialog --title "CONTROL DE SCRIPTS" \
            --stdout \
            --inputbox "\nUna valor mas alto permite utilizar más swap. \n\nSu valor actual es \n\nvm.swappiness = $consultar_swap \n\nElige un nuevo valor" 23 36)
      returncode=$?
      if [[ $returncode = 0 ]]; then
        if [[ ($valor_swap != *[^0-9]*) && ($valor_swap != "") ]]; then
          if [[ $valor_swap -ge 0 && $valor_swap -le 100 ]]; then
            opcion_valida="true"
	        local modificar_swap=`sudo sysctl vm.swappiness=$valor_swap`
	        echo "Se ha modificado la swap al valor $modificar_swap"
          else
            opcion_valida="false"
            echo "Debe ser una cantidad entre 0 y 100"
          fi
        else
          opcion_valida="false"
          echo "El dato tiene que ser numerico"
        fi
      else
        opcion_valida="true"
        echo "Operacion cancelada"
      fi
    read -p " Presiones cualquier tecla para continua... "
    done
}

ajustar_swap_v2
