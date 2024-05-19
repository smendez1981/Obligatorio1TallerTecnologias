#!/bin/bash

# Integrantes********************************************************
# 328226 - Manuel Pallares 
# 143403 - Sebastián Méndez 
# *******************************************************************

# Constante donde se guarda la ruta del archivo que 
# se usará para guardar las variables
ARCHIVOVARIABLES="files/variables.config"



# Funcion que se encarga  de leer la configuración 
# Se le debe de pasar la clave del valor a recuperar.
LeerConfig() {

    # Verificar si se proporcionó un nombre de clave como argumento
    if [ $# -ne 1 ]; then
        echo "Uso: LeerConfig <clave>"
        return 1
    fi

    local clave="$1"

    # Verificar si el archivo de configuración existe
    if [ ! -f "$ARCHIVOVARIABLES" ]; then
        echo "El archivo de configuración $ARCHIVOVARIABLES no existe."
        return 1
    fi

    # Buscar la clave en el archivo de configuración y devolver su valor
    local valor=$(grep "^$clave=" "$ARCHIVOVARIABLES" | cut -d '=' -f 2)
    if [ -z "$valor" ]; then
        echo "No se encontró el valor para la clave '$clave' en el archivo de configuración."
        return 1
    fi

    echo "$valor"
}


# Funcion encargada de guardar la letra  en el arhivo de configuración
# Se le pasa como parametro si es Inicio, Fin, Contenida o Vocal.
GuardarLetra() {

    #variables locales: clave, que almacena el nombre de la variable a modificar o agregar
    #en el archivo de variables, y valor, que almacenará el valor ingresado por el usuario.
    local clave=$1
    local valor

    # Utiliza un bucle while para asegurarse de que el usuario ingrese un valor para la letra de inicio.
    # Si el usuario no ingresa nada, muestra un mensaje de error en rojo.
    while [ -z "$valor" ]; do

        read -p "Ingrese el valor de la letra ${clave}:" valor

        if ! [ "$valor" ]; then
            echo ""
            echo -e "\033[31mEl valor de la letra ${clave} no puede quedar en blanco\033[0m"
        fi

        # Si el parametro clave es vocal reviso el dato
        # que me pasen sea una vocal usando una regex.
        if [[ "${clave}" == "Vocal" ]]; then

            valor_minuscula=$(echo "$valor" | tr "[:upper:]" "[:lower:]")
            regex_vocal="[aeiou]"

            if [[ ! "$valor_minuscula" =~ $regex_vocal ]]; then
                echo ""
                echo -e "\033[31mValores permitidos (a-e-i-o-u)\033[0m"
                valor=""
            fi
        else

            # Luego, verifica si el valor ingresado contiene caracteres que no sean letras del alfabeto.
            # Si es así, muestra un mensaje de error en rojo y limpia el valor para que el usuario tenga que ingresar uno nuevo.
            if [[ "${valor}" =~ [^a-zA-Z] ]]; then
                echo ""
                echo -e "\033[31mValores permitidos (Aa-Zz)\033[0m"
                valor=""
            fi

        fi

    done

    # Comprobar si la variable ya existe en el archivo
    if grep -q "^$clave=" "$ARCHIVOVARIABLES"; then
        # La variable existe, modificar su valor
        sed -i "s/^$clave=.*/$clave=${valor:0:1}/" "$ARCHIVOVARIABLES"
        echo ""
        echo "La letra ${clave} ha sido modificada con el valor '$valor'."
    else
        # La variable no existe, agregarla al final del archivo
        echo "$clave=${valor:0:1}" >>"$ARCHIVOVARIABLES"
        echo ""
        echo "La letra ${clave} ha sido agregada con el valor '$valor'."
    fi

    echo ""
    read -p "Presiona Enter para continuar..."
    MenuPrincipal
}
