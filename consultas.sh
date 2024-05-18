#!/bin/bash

# Constante donde se guarda la ruta del archivo que
# contiene el diccionario suministrado.
ARCHIVODICCIONARIO="files/diccionario.txt"

# Función que se encarga de obtener las palabras
# del diccionario que unicamente contengan la
# vocal que previamente se configuró
ConsultarVocal() {
    # Recupera la vocal guardada en el archivo de configuración
    vocal="$(LeerConfig "Vocal")"
    regex_vocal="^aeiou"
    # buscar la palabra usando grep -E para usar expresiones regulares
    palabrasEncontradas=$(grep -E "^([^aeiou]*(${vocal}|${vocal}^^)[^aeiou]*)+$" "$ARCHIVODICCIONARIO")
    echo "Palabras encontradas que únicamente contienen la vocal $vocal:"
    echo "$palabrasEncontradas"
    echo "Busqueda terminada"
    read -p "Presiona Enter para continuar..."
}

# Función que se encarga de obtener las palabras
# del diccionario que contengan la LetraInicial
# LetraFinal y LetraContenida que previamente se configuró
ConsultarDiccionario() {
    # Recupera las variables guardadas en el
    # archivo de configuracion
    letraInicio="$(LeerConfig "Inicio")"
    letraFin="$(LeerConfig "Fin")"
    letraContenida="$(LeerConfig "Contenida")"

    # Construir la expresión regular para buscar palabras
    # Empieza con "letraInicio"
    # Termina con "LetraFin"
    # En medio tiene "LetraContenida"
    regex="^${letraInicio}.*${letraContenida}.*${letraFin}$"
    # wc (Word Count) cuenta la cantida de palabras, el parametro -l hace que cuenta la cantidad de lineas
    cantidadPalabrasEnDiccionario=$(wc -l <"$ARCHIVODICCIONARIO")
    cantidadPalabrasEnDiccionario=$((cantidadPalabrasEnDiccionario + 1))
    # usamos grep para buscar las palabras que cumplen con la expresion regular
    palabrasEncontradas=$(grep -E "$regex" "$ARCHIVODICCIONARIO")
    # usamos if -z para verificar si se encontraron palabras
    if [ -z "$palabrasEncontradas" ]; then
        cantidadPalabrasEncontradas=0
    else
        # usamos grep -c para contar las líneas no vacías
        cantidadPalabrasEncontradas=$(echo "$palabrasEncontradas" | grep -c .)
    fi
    porcentajeAciertos=$(echo "scale=2; $cantidadPalabrasEncontradas / $cantidadPalabrasEnDiccionario * 100" | bc)

    echo "Cantidad de palabras encontradas: $cantidadPalabrasEncontradas"
    echo "Total de palabras en diccionario: $cantidadPalabrasEnDiccionario"
    echo "Porcentaje de palabras encontradas: $porcentajeAciertos"
    echo "Palabras encontradas:"
    echo "$palabrasEncontradas"

    # Creacion de archivo que se guarda con
    # los resultados de la busqueda.
    # resultados_YYYY-mm-dd_HH-MM-ss
    fechaHora=$(date +"%Y-%m-%d_%H-%M-%S")
    archivoSalida="resultados/resultados_${fechaHora}.txt"
    touch "$archivoSalida"

    echo "$palabrasEncontradas" >>"$archivoSalida"
    # Fecha de ejecutado el reporte
    echo "" >>"$archivoSalida"
    fecha="Fecha ejecución reporte: $(date +'%d/%m/%Y %H:%M:%S')"
    echo "$fecha"
    echo "$fecha" >>"$archivoSalida"

    #Cantidad de palabras encontradas
    echo "Cantidad de palabras encontradas: ${cantidadPalabrasEncontradas}" >>"$archivoSalida"

    #Cantidad de palabras totales
    echo "Cantidad de palabras totales: ${cantidadPalabrasEnDiccionario}" >>"$archivoSalida"

    #Porcentajes que cumplen lo pedido
    echo "Porcentaje aciertos: ${porcentajeAciertos}%" >>"$archivoSalida"

    #Usuario logueado
    usuario="$(LeerConfig "Usuario")"
    usuarioLogueado="Usuario logueado: ${usuario}"
    echo "$usuarioLogueado"
    echo "$usuarioLogueado" >>"$archivoSalida"

    read -p "Presiona Enter para continuar..."
}
