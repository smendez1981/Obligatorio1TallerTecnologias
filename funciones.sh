#!/bin/bash

ARCHIVOUSUARIOS="usuarios.txt"
ARCHIVOVARIABLES="variables.config"
ARCHIVODICCIONARIO="diccionario.txt"
USUARIO=""

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

MenuPrincipal() {
    clear
    echo "---------------------------------------"
    echo "---------Bienvenido al sistema---------"
    echo "---------------------------------------"
    echo " 1 - Listar usuarios registros"
    echo " 2 - Alta de usuario"
    echo " 3 - Configurar letra inicial"
    echo " 4 - Configurar letra final"
    echo " 5 - Configurar letra contenida"
    echo " 6 - Consultar diccionario"
    echo " 7 - Ingresar vocal"
    echo " 8 - Listar palabras de vocal ingresada"
    echo " 9 - Algoritmo 1"
    echo "10 - Algoritmo 2"
    echo " X - Salir"
    echo "----------------------------------------"
}

ControladorOpcionesMenu() {
    local opcion=$1
    case $opcion in
    1)
        echo ""
        echo "Listado de  usuarios registros"
        echo "----------------------------------------"
        ListarUsuarios
        echo "----------------------------------------"
        ;;
    2)
        echo ""
        echo "Alta de usuario"
        echo "----------------------------------------"
        AltaUsuario
        echo "----------------------------------------"
        ;;
    3)
        echo ""
        echo "Configurar letra de inicio"
        echo "----------------------------------------"
        GuardarLetra "Inicio"
        ;;
    4)
        echo ""
        echo "Configurar letra de fin"
        echo "----------------------------------------"
        GuardarLetra "Fin"
        ;;
    5)
        echo ""
        echo "Configurar letra contenida"
        echo "----------------------------------------"
        GuardarLetra "Contenida"
        ;;
    6)
        echo ""
        echo "Consultando diccionario..."        
        
        ConsultarDiccionario
        ;;
    7)
        echo "Has seleccionado la Opción Ingresar vocal"

        ;;
    8)
        echo "Has seleccionado la Opción Listar palabras de vocal ingresada"

        ;;
    9)
        echo "Has seleccionado la Opción Algoritmo 1"

        ;;
    10)
        echo "Has seleccionado la Opción Algoritmo 2"

        ;;
    x)
        echo "Saliendo..."
        exit 0
        ;;
    *)
        echo "Opción inválida. Por favor, selecciona una opción válida."
        ;;
    esac
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
        echo $usuDb
    done <$ARCHIVOUSUARIOS
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

#Funcion encargada de guardar la letra  en el arhivo de configuracion
#Se le pasa como parametro si es Inicio, Fin o Contenida
GuardarLetra() {

    #variables locales: clave, que almacena el nombre de la variable a modificar o agregar
    #en el archivo de variables, y valor, que almacenará el valor ingresado por el usuario.
    local clave=$1
    local valor

    #Utiliza un bucle while para asegurarse de que el usuario ingrese un valor para la letra de inicio.
    #Si el usuario no ingresa nada, muestra un mensaje de error en rojo.
    while [ -z "$valor" ]; do

        read -p "Ingrese el valor de la letra ${clave}:" valor

        if ! [ "$valor" ]; then
            echo ""
            echo -e "\033[31mEl valor de la letra ${clave} no puede quedar en blanco\033[0m"
        fi

        #Luego, verifica si el valor ingresado contiene caracteres que no sean letras del alfabeto.
        #Si es así, muestra un mensaje de error en rojo y limpia el valor para que el usuario tenga que ingresar uno nuevo.
        if [[ "${valor}" =~ [^a-zA-Z] ]]; then
            echo ""
            echo -e "\033[31mValores permitidos (Aa-Zz)\033[0m"
            valor=""
        fi

    done

    # Comprobar si la variable ya existe en el archivo
    if grep -q "^$clave=" "$ARCHIVOVARIABLES"; then
        # La variable existe, modificar su valor
        sed -i "s/^$clave=.*/$clave=$valor/" "$ARCHIVOVARIABLES"
        echo ""
        echo "La letra ${clave} ha sido modificada con el valor '$valor'."
    else
        # La variable no existe, agregarla al final del archivo
        echo "$clave=$valor" >>"$ARCHIVOVARIABLES"
        echo ""
        echo "La letra ${clave} ha sido agregada con el valor '$valor'."
    fi

    echo ""
    read -p "Presiona Enter para continuar..."
    MenuPrincipal
}

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


ConsultarDiccionario()
{
        contadorPalabrasEncontradas=0
        contadorTotal=0

        fechaHora=$(date +"%Y-%m-%d_%H-%M-%S")        
        archivoSalida="resultados_${fechaHora}.txt"
        touch "$archivoSalida"

        letraInicio="$(LeerConfig "Inicio")"
        letraFin="$(LeerConfig "Fin")"
        letraContenida="$(LeerConfig "Contenida")"
      
        echo "$letraInicio"
        echo "$letraFin"
        echo "$letraContenida"
 
            # Construir la expresión regular para buscar palabras
            regex="^${letraInicio}.*${letraContenida}.*${letraFin}$"
            
            # Usar while read para leer el archivo línea por línea
            while IFS= read -r palabra; do
                # Verificar si la palabra cumple con la expresión regular
                if [[ "$palabra" =~ $regex ]]; then
                    echo "$palabra"
                    echo "$palabra" >> "$archivoSalida"
                    contadorPalabrasEncontradas=$((contadorPalabrasEncontradas+1))
                fi

                 contadorTotal=$((contadorTotal+1))

            done < "$ARCHIVODICCIONARIO" 

            #Fecha de ejecutado el reporte
            echo "" >> "$archivoSalida"
            echo "" >> "$archivoSalida"
            fecha="Fecha ejecución reporte: $(date +'%d/%m/%Y %H:%M:%S')"
            echo "$fecha"
            echo "$fecha" >> "$archivoSalida"

            #Cantidad de palabras encontradas
            echo "" >> "$archivoSalida"
            palabrasEncontradas="Cantidad de palabras encontradas: ${contadorPalabrasEncontradas}" 
            echo $palabrasEncontradas    
            echo "$palabrasEncontradas" >> "$archivoSalida"
            
            #Cantidad de palabras totales
            echo "" >> "$archivoSalida"
            palabrasTotales="Cantidad de palabras totales: ${contadorTotal}" 
            echo $palabrasTotales
            echo "$palabrasTotales" >> "$archivoSalida" 

            #Porcentajes que cumplen lo pedido
            echo "" >> "$archivoSalida"             
            porcentaje=$(echo "scale=2; ($contadorPalabrasEncontradas * 100) / $contadorTotal" | bc) 
            echo "Porcentaje aciertos: ${porcentaje}%"
            echo "Porcentaje aciertos: ${porcentaje}%" >> "$archivoSalida" 


            #Usuario logueado
            echo "" >> "$archivoSalida"              
            usuario="$(LeerConfig "Usuario")"
            usuarioLogueado="Usuario logueado: ${usuario}"
            echo $usuarioLogueado
            echo "$usuarioLogueado" >> "$archivoSalida" 
 
            



        read -p "Presiona Enter para continuar..."


}