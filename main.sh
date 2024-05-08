#!/bin/bash


#Carga de script con funcion auxiliar "Login"***************** 
source ./seguridad.sh
#*************************************************************


#Declaracion de variables*************************************
usuario=""
password=""
#Fin declaracion de variables*********************************


#Entrada del programa*****************************************

# ************************************************************
# Inicio  de sesion********************************************
 # ************************************************************
 

echo ""
echo "-----------------"
echo "Inicio  de sesión"
echo "-----------------"
echo ""

# Este bucle while se ejecutará mientras la variable $usuario esté vacía 
# es decir, su longitud es cero), lo que se verifica con [ -z "$usuario" ]
while [ -z "$usuario" ] 
do

    # Esta línea solicita al usuario que ingrese su nombre de usuario. 
    # La entrada del usuario se almacena en la variable $usuario.
    read -p  "Ingrese su usuario: " usuario

    # Esta condición verifica si la variable $usuario está vacía. 
    # La expresión ! [ "$usuario" ] devuelve verdadero si la variable está vacía.
    if ! [ "$usuario" ] 
    then
        # Si la variable $usuario está vacía, este comando imprime un mensaje de error 
        # en rojo indicando que el nombre de usuario no puede quedar en blanco.
        echo -e "\033[31mEl nombre de usuario no puede quedar en blanco\033[0m"     
    fi

done

# Una vez que el usuario proporciona un nombre de usuario 
# (es decir, la variable $usuario ya no está vacía), el bucle while termina 
# y el script continúa con las instrucciones que siguen después del bucle.
 

#  Este bucle while se ejecutará mientras la variable $password esté vacía 
# (es decir, su longitud es cero), lo que se verifica con [ -z "$password" ].
while [ -z "$password" ] 
do
  
    # Esta línea solicita al usuario que ingrese su contraseña de forma segura,
    # lo que significa que la entrada del usuario no se mostrará en la pantalla. 
    # La opción -s de read logra este comportamiento. 
    # La contraseña ingresada por el usuario se almacena en la variable $password.
    read -s -p  "Ingrese su password:"  password     

    #  Esta condición verifica si la variable $password está vacía. 
    # La expresión ! [ "$password" ] devuelve verdadero si la variable está vacía.
    if ! [ "$password" ] 
    then
        # Si la variable $password está vacía, este comando imprime un mensaje 
        # de error en rojo indicando que el password no puede quedar en blanco.
        echo -e "\033[31mEl password de usuario no puede quedar en blanco\033[0m"     
    fi

done 
  
 echo ""
 
# Una vez que el usuario proporciona una contraseña 
# (es decir, la variable $password ya no está vacía), 
# el bucle while termina y el script continúa con las 
# instrucciones que siguen después del bucle.
# Se llama a la funciòn "Login" pasandole las variables 
# anteriormente obtenidas  
 if Login "$usuario" "$password";
 then      

     sleep 1
     
     # Si el inicio de sessión es correcto se entra en un bucle
     # en el cual se despliega el menú de usuario.
     # Luego de seleccionada cada opción y ejecutado el código
     # que tenga asociado, se vuelve a mostrar el menù.
     while [ true ]; do
        MenuPrincipal
        # Se lee la opcion elegida por el usuario y se le pasa
        # al controlador de opciones del menú.
        read -p "Por favor, selecciona una opción: " opcion
        ControladorOpcionesMenu $opcion
        echo    
    done

 else
    # En caso de login con error se muestra mensaje y se sale del programa
     echo "Usuario o password incorrecto"
     exit 1
 fi
 
 
#Fin de inicio de sesion*****************************************
