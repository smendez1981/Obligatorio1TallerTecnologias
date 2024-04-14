#!/bin/bash


#Carga de script con funciones auxiliares********************
source ./funciones.sh
#************************************************************


#Declaracion de variables************************************
usuario=""
password=""
#Fin declaracion de variables********************************

#Inicio  de sesion********************************************

# Bucle while que solicita al usuario que ingrese su nombre de usuario hasta que se proporcione una entrada no vacía.  

#     while [ -z "$usuario" ]: Este bucle while se ejecutará mientras la variable $usuario esté vacía (es decir, su longitud es cero), lo que se verifica con [ -z "$usuario" ].

#     read -p "Ingrese su usuario: " usuario: Esta línea solicita al usuario que ingrese su nombre de usuario. La entrada del usuario se almacena en la variable $usuario.

#     if ! [ "$usuario" ]: Esta condición verifica si la variable $usuario está vacía. La expresión ! [ "$usuario" ] devuelve verdadero si la variable está vacía.

#     echo -e "\033[31mEl nombre de usuario no puede quedar en blanco\033[0m": Si la variable $usuario está vacía, este comando imprime un mensaje de error en rojo indicando que el nombre de usuario no puede quedar en blanco.

#     fi: Marca el final de la estructura if.

# Una vez que el usuario proporciona un nombre de usuario (es decir, la variable $usuario ya no está vacía), el bucle while termina y el script continúa con las instrucciones que siguen después del bucle.

while [ -z "$usuario" ] 
do

    read -p  "Ingrese su usuario: " usuario

    if ! [ "$usuario" ] 
    then
        echo -e "\033[31mEl nombre de usuario no puede quedar en blanco\033[0m"     
    fi

done


# Este bloque de código Bash crea un bucle while que solicita al usuario que ingrese su contraseña hasta que se proporcione una entrada no vacía.  

#     while [ -z "$password" ]: Este bucle while se ejecutará mientras la variable $password esté vacía (es decir, su longitud es cero), lo que se verifica con [ -z "$password" ].

#     read -s -p "Ingrese su password:" password: Esta línea solicita al usuario que ingrese su contraseña de forma segura, lo que significa que la entrada del usuario no se mostrará en la pantalla. La opción -s de read logra este comportamiento. La contraseña ingresada por el usuario se almacena en la variable $password.

#     if ! [ "$password" ]: Esta condición verifica si la variable $password está vacía. La expresión ! [ "$password" ] devuelve verdadero si la variable está vacía.

#     echo -e "\033[31mEl password de usuario no puede quedar en blanco\033[0m": Si la variable $password está vacía, este comando imprime un mensaje de error en rojo indicando que el password no puede quedar en blanco.

#     fi: Marca el final de la estructura if.

# Una vez que el usuario proporciona una contraseña (es decir, la variable $password ya no está vacía), el bucle while termina y el script continúa con las instrucciones que siguen después del bucle.

while [ -z "$password" ] 
do
  
    read -s -p  "Ingrese su password:"  password     

    if ! [ "$password" ] 
    then
        echo -e "\033[31mEl password de usuario no puede quedar en blanco\033[0m"     
    fi

done 
  
 echo ""

 if Login "$usuario" "$password";
 then      

     sleep 1
     
     while true; do
        MenuPrincipal
        read -p "Por favor, selecciona una opción: " opcion
        ControladorOpcionesMenu $opcion
        echo
        
    done

 else
     echo "Usuario o password incorrecto"
     exit 1
 fi
 
 
#Fin de inicio de sesion*****************************************
