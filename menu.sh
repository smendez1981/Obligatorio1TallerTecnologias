#!/bin/bash
 

source ./configuracion.sh
source ./consultas.sh
source ./algoritmos.sh

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
        echo ""
        echo "Configurar Vocal"
        echo "----------------------------------------"
        GuardarLetra "Vocal"
        ;;
    8)
        echo ""
        echo "Consultando vocal..."
        ConsultarVocal
        ;;
    9)
        echo "Opción Algoritmo 1"
        echo "----------------------------------------"
        Algoritmo1
        ;;
    10)
        echo "Opción Algoritmo 2"
        echo "----------------------------------------"
        Palindromo
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


 