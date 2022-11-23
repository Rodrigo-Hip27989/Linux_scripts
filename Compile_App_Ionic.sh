#!/bin/sh
# -*- ENCODING: UTF-8 -*-

# CONSTANTES
TITULO="Compilar App Ionic"
YES=0
NO=1
path_android_studio="/media/Toronja/shared/linux/android-studio"
# Titulos
tipo_bold_fuente_green_fondo_blue="\e[1;32;44m"
# Texto
tipo_bold_fuente_green="\e[1;32m"

menu(){
	local only_dirs=$(exa --only-dirs)
	local selected_project
	while true;
	do
		selected_project=$(dialog --clear --title "${TITULO}" --stdout \
		--menu "\n	Elije un proyecto para compilar \n " 15 40 5 \
	       $(get_list_options_directories $(ArrayToStr ${only_dirs[@]}))
	    )
	    compilar__app ${selected_project}
	done
}

compilar__app(){
	local selected_project=${1}
	cd ${selected_project}
    $(dialog --title "${TITULO}" --stdout \
         --yesno "\nLa carpeta elegida fue: \n\n${selected_project} \
         \n\n¿Desea abrir android studio al finalizar?" 15 40)
	returncode=$?
	clear
	# Si existe la carpeta android
	if [[ -d "$(pwd)/android" ]]
	then
	    echo -e "\n${tipo_bold_fuente_green_fondo_blue} Compilando => ${selected_project} ... \n\e[0m"
		echo -e "\n${tipo_bold_fuente_green_fondo_blue} Ejecutando => ionic build \n\e[0m"
		ionic build
		echo -e "\n${tipo_bold_fuente_green_fondo_blue} Ejecutando => npx cap sync android \n\e[0m"
		npx cap copy android
#		npx cap sync android
	else
	    echo -e "\n${tipo_bold_fuente_green_fondo_blue} Compilando por primera vez => ${selected_project} ... \n\e[0m"
		echo -e "\n${tipo_bold_fuente_green_fondo_blue} Ejecutando => ionic build \n\e[0m"
		ionic build
		echo -e "\n${tipo_bold_fuente_green_fondo_blue} Ejecutando => npx cap add android \n\e[0m"
		npx cap add android
		echo -e "\n${tipo_bold_fuente_green_fondo_blue} Ejecutando => npx cap sync android \n\e[0m"
		npx cap sync android
	fi
	if [[ ${returncode} -eq ${YES} ]]
	then
	    echo -e "\n${tipo_bold_fuente_green_fondo_blue} Abriendo Android Studio... \n\e[0m"
		cd "${path_android_studio}"
		bash ./bin/studio.sh
	fi
	echo -e "\n${tipo_bold_fuente_green_fondo_blue} Terminado!\n\n Presiones ENTER para continuar... \n\e[0m"
	read
}

################################################
ArrayToStr(){
	local my_array_to_string=${@}
   	echo ${my_array_to_string// /---}
}

StrToArray(){
	local my_string_to_array=${@}
   	echo ${my_string_to_array//---/ }
}
# Solo acepta array en formato string separado por '---' como se indica en estas funciones
get_list_options_directories(){
   	declare -a directorios=($(StrToArray ${1}))
   	declare -a dirs_for_menu=()
	for item in ${directorios[@]}
 	do
    	dirs_for_menu=("${dirs_for_menu[@]}" "${item}" ".")
	done
	echo ${dirs_for_menu[@]}
}
################################################

menu
