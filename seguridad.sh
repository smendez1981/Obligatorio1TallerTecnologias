#!/bin/bash

source ./menu.sh

ARCHIVOUSUARIOS="files/usuarios.txt"
ARCHIVOVARIABLES="files/variables.config"

#Funcion de login***************************************************

# Este script de Bash es una función que recibe dos parámetros: $usu y $pwd.
# Luego, itera sobre un archivo ($ARCHIVOUSUARIOS) que contiene pares de
# usuarios y contraseñas separados por dos puntos (:).

# Aquí hay una explicación línea por línea:

#     local usu=$1: Declara una variable local $usu y le asigna el primer argumento pasado a la función.

#     local pwd=$2: Declara una variable local $pwd y le asigna el segundo argumento pasado a la función.

#     while IFS=":" read -r usuDb pwdDb;: Inicia un bucle while que lee cada línea del archivo $ARCHIVOUSUARIOS y divide cada línea en dos campos utilizando : como delimitador. Los campos se almacenan en las variables $usuDb y $pwdDb.

#     do: Inicia el bloque de código que se ejecutará en cada iteración del bucle.

#     echo $usuDb: Imprime el valor de $usuDb, que es el nombre de usuario extraído del archivo.

#     echo $pwd: Imprime el valor de $pwd, que es la contraseña pasada como argumento a la función.

#     if [[ $usu==$usuDb && $pwd==$pwdDb ]]; then: Comprueba si el nombre de usuario $usu coincide con $usuDb y si la contraseña $pwd coincide con $pwdDb.

#     return 0: Devuelve un código de salida 0 (éxito) si se encuentra una coincidencia entre el usuario y la contraseña en el archivo.

#     fi: Cierra la estructura de control if.

#     done < $ARCHIVOUSUARIOS: Cierra el bucle while y redirige la entrada del bucle desde el archivo $ARCHIVOUSUARIOS.

#     return 1: Devuelve un código de salida 1 (fracaso) si no se encuentra ninguna coincidencia entre el usuario y la contraseña en el archivo.

Login() {
    local usu=$1
    local pwd=$2

    while IFS=":" read -r usuDb pwdDb; do

        if [[ "$usu" == "$usuDb" && "$pwd" == "$pwdDb" ]]; then
            clave="Usuario"
            sed -i "s/^$clave=.*/$clave=$usu/" "$ARCHIVOVARIABLES"

            return 0
        fi
    done <$ARCHIVOUSUARIOS

    return 1
}



# La función ListarUsuarios lee el archivo de usuarios y contraseñas y
# luego imprime solo los nombres de usuario, uno por línea.
#     while IFS=":" read -r usuDb pwdDb; do: Este bucle while lee cada línea del
#     archivo $ARCHIVOUSUARIOS y divide cada línea en dos campos utilizando : como delimitador. Los campos se almacenan en las variables $usuDb (nombre de usuario) y $pwdDb (contraseña).
#     echo $usuDb: Esta línea imprime el nombre de usuario ($usuDb) en la salida estándar.
#     done < $ARCHIVOUSUARIOS: Marca el final del bucle while y redirige la entrada del bucle desde el archivo especificado por la variable $ARCHIVOUSUARIOS.
# La función ListarUsuarios proporciona una forma de mostrar los nombres de usuario contenidos en el archivo $ARCHIVOUSUARIOS.

ListarUsuarios() {

    while IFS=":" read -r usuDb pwdDb; do
        echo "$usuDb"
    done <$ARCHIVOUSUARIOS

    read -p "Presiona Enter para continuar..."
    MenuPrincipal

}
#**********************************************************************************************

# AltaUsuario, se encarga de agregar un nuevo usuario al archivo de usuarios

#     local password y local usuario: Estas líneas definen dos variables locales,
#     $password y $usuario, respectivamente, que se utilizarán para almacenar el
#     nombre y la contraseña del nuevo usuario.

#     while [ -z "$usuario" ]: Este bucle while se ejecutará mientras la variable $usuario
#     esté vacía.

#     read -p "Ingrese nombre del nuevo usuario : " usuario: Esta línea solicita al usuario
#     que ingrese el nombre del nuevo usuario y almacena la entrada en la variable $usuario.

#     if ExisteUsuario "$usuario"; then: Esta condición verifica si el nombre de usuario
#     ingresado ($usuario) ya existe. La función ExisteUsuario se encarga de verificar si
#     el usuario ya está presente en el sistema.

#     echo -e "\033[31mEl nombre '$usuario' ya se encuentra ingresado\033[0m":
#     Si el usuario ya existe, este mensaje de error se imprime en rojo.

#     while [ -z "$password" ]: Este bucle while se ejecutará mientras la variable
#     $password esté vacía.

#     read -s -p "Ingrese su password:" password: Esta línea solicita al usuario que
#     ingrese la contraseña del nuevo usuario de forma segura, y la entrada se almacena
#     en la variable $password. La opción -s oculta la entrada de la contraseña en la
#     pantalla.

#     if ! [ "$password" ]: Esta condición verifica si la contraseña está vacía.

#     echo -e "\033[31mEl password de usuario no puede quedar en blanco\033[0m":
#     Si la contraseña está vacía, se imprime un mensaje de error en rojo.

#     echo "$usuario:$password" >> "$ARCHIVOUSUARIOS": Esta línea agrega la nueva
#     entrada de usuario (nombre de usuario y contraseña) al archivo de usuarios
#     especificado en la variable $ARCHIVOUSUARIOS.

#     MenuPrincipal: Esta línea regresa al menú principal después de agregar el usuario.
AltaUsuario() {
    local password
    local usuario

    while [ -z "$usuario" ]; do

        read -p "Ingrese nombre del nuevo usuario : " usuario

        if ExisteUsuario "$usuario"; then
            echo -e "\033[31mEl nombre '$usuario' ya se encuentra ingresado\033[0m"
            read -p "Presiona Enter para continuar..."
            AltaUsuario
        else

            while [ -z "$password" ]; do
                read -s -p "Ingrese su password:" password

                if ! [ "$password" ]; then
                    echo -e "\033[31mEl password de usuario no puede quedar en blanco\033[0m"
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