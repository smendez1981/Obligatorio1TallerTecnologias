#!/bin/bash


# Función que devuelve el promedio de los datos ingresados,
# el menor y mayor dato ingresado
Algoritmo1() {
    echo ""
    read -p "Ingrese la cantidad de datos que desea ingresar: " cantidadDatos

    # Verificar si la cantidad ingresada es un número positivo
    if ! [[ "$cantidadDatos" =~ ^[1-9][0-9]*$ ]]; then
        echo "Debe ingresar un número entero positivo."
        read -p "Presiona Enter para continuar..."
        Algoritmo1
    else

        # Inicializar variables
        menor=
        mayor=
        suma=0
        promedio=0

        # Leer los datos ingresados por el usuario y calcular el menor y el mayor
        for ((i = 1; i <= "$cantidadDatos"; i++)); do
            read -p "Ingrese el dato $i: " dato

            # Verificar si el dato ingresado es un número entero
            if ! [[ $dato =~ ^[0-9]+$ ]]; then
                echo "Debe ingresar un número entero."
                read -p "Presiona Enter para continuar..."
                Algoritmo1
            fi

            # Actualizar el menor y el mayor dato
            if [ -z "$menor" ] || [ "$dato" -lt "$menor" ]; then
                menor=$dato
            fi

            if [ -z "$mayor" ] || [ "$dato" -gt "$mayor" ]; then
                mayor=$dato
            fi

            #echo "Menor dato: ${menor}"
            suma=$((suma + dato))
        done

        # Mostrar los resultados
        echo ""
        promedio=$(echo "scale=2; $suma / $cantidadDatos" | bc)
        echo "Promedio de los datos ingresados: ${promedio}"
        echo "Menor dato ingresado: ${menor}"
        echo "Mayor dato ingresado: ${mayor}"
        echo ""
        read -p "Presiona Enter para continuar..."
        MenuPrincipal

    fi
}

# Función que devuelve si la palabra que se le 
# pasa como parámetro es un palindromo.
Palindromo() {
    local palabra=""    
    local palabrareversa=""

    read -p "Ingrese la palabra $i: " palabra
    local largo=${#palabra}

    # Obtener el reverso de la palabra
    for ((i = $largo - 1; i >= 0; i--)); do
        palabrareversa="$palabrareversa${palabra:$i:1}"
    done


echo "$palabrareversa"
echo "$palabra"
    # Comparar la palabra original con su reverso
    if [ "$palabra" == "$palabrareversa" ]; then
        echo "La palabra \"$palabra\" es un palíndromo."
    else
        echo "La palabra \"$palabra\" no es un palíndromo."
    fi

    echo ""
    read -p "Presiona Enter para continuar..."
    MenuPrincipal
}
