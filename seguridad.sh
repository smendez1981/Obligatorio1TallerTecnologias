#!/bin/bash

# Integrantes********************************************************
# 328226 - Manuel Pallares 
# 143403 - Sebastián Méndez 
# *******************************************************************

# Carga del script que contienen la funcionalidad
# para volver al menú una vez terminada la rutina
source ./menu.sh

# Constante donde se guarda la ruta del archivo que
# contiene el listado de usuarios del sistema.
ARCHIVOUSUARIOS="files/usuarios.txt"
# Constante donde se guarda la ruta del archivo que
# contiene el las diferentes variables guardadas.
ARCHIVOVARIABLES="files/variables.config"

#Funcion de login***************************************************

# Función que recibe dos parámetros: $usu y $pwd.
# Luego, itera sobre un archivo ($ARCHIVOUSUARIOS) que contiene pares de
# usuarios y contraseñas separados por dos puntos (:).
Login() {
    local usu=$1
    local pwd=$2

    while IFS=":" read -r usuDb pwdDb; do

        if [[ "$usu" == "$usuDb" && "$pwd" == "$pwdDb" ]]; then
            clave="Usuario"
            #sed -i se usa para editar el archivo de variables
            #sustituyendo el valor de la variable $clave por el valor de $usu
            sed -i "s/^$clave=.*/$clave=$usu/" "$ARCHIVOVARIABLES"

            return 0
        fi
    done <$ARCHIVOUSUARIOS

    return 1
}

# La función ListarUsuarios lee el archivo de usuarios y contraseñas,
# luego imprime solo los nombres de usuario, uno por línea.
ListarUsuarios() {

    # while IFS=":" read -r usuDb pwdDb; do
    #      echo "$usuDb"
    # done <$ARCHIVOUSUARIOS
    awk -F ':' '{print $1}' $ARCHIVOUSUARIOS

    read -p "Presiona Enter para continuar..."
    MenuPrincipal
}
#**********************************************************************************************

# AltaUsuario, se encarga de agregar un nuevo usuario al archivo de usuarios.
# Se pide nombre de usuario y se revisa que este ya no exista. En caso de que
# ya exista se vuelve a pedir los datos nuevamente.
# Se revisa tambien que se haya ingresado un password.
# En caso de que se cumplan las condiciones, se redirecciona la salida
# de los datos ingresados al archivo que contiene el listado de usuarios
# los cuales son anexados al final.
AltaUsuario() {
    local password
    local usuario

    while [ -z "$usuario" ]; do

        read -p "Ingrese nombre del nuevo usuario : " usuario

        if ExisteUsuario "$usuario"; then
            echo -e "\033[31mEl nombre '$usuario' ya se encuentra registrado\033[0m"
            read -p "Presiona Enter para continuar..."
            AltaUsuario
        else

            while [ -z "$password" ]; do
                read -s -p "Ingrese su password:" password

                if ! [ "$password" ]; then
                    echo -e "\033[31mEl password del usuario no puede quedar en blanco\033[0m"
                fi

            done

            echo "$usuario:$password" >>"$ARCHIVOUSUARIOS"
            echo ""
            echo "Usuario agregado correctamente"
            echo ""
            read -p "Presiona Enter para continuar..."
            MenuPrincipal
        fi

    done

}

# ExisteUsuario usa el comando grep -q busca la cadena "usuario1"
# al comienzo de cada línea (^) seguida de : en el archivo archivo de usuarios.
# El argumento -q hace que grep funcione en modo silencioso,
# lo que significa que no imprimirá ninguna salida en la consola.
# Se establece su código de salida como 0 si encuentra una coincidencia
# y como 1 si no la encuentra.
ExisteUsuario() {
    local usuario=$1

    if grep -q "^$usuario:" "$ARCHIVOUSUARIOS"; then
        return 0
    else
        return 1
    fi

}
