#!/bin/sh
# -*- ENCODING: UTF-8 -*-

ajustar_swap(){
	local valor=50
	local consultar_swap=`cat /proc/sys/vm/swappiness`
	echo && echo
	echo "   Una valor mas alto permite utilizar más swap"
	echo "   La configuración actual del Swap es"
	echo "   vm.swappiness = $consultar_swap"
	echo && echo
	echo "    MODIFICANDO EL SWAP..."
	echo && echo
	local modificar_swap=`sudo sysctl vm.swappiness=$valor`
	echo "    Se ha modificado la swap al valor => $modificar_swap"
	read -p "    Presione una tecla para continuar"
}

ajustar_swap
