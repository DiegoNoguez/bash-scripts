#!/bin/bash
#esto es comentario dentreo del lenguaje de sh o shell 
#La siguiente estructura es como se hace una funcion en shell
#epera parametros fuera de la funcion.
    numero=1
    numero1=2
function suma () {
    sumar=$(($numero+$numero1))
    echo "la suma de $numero+ $numero1  es $sumar"
}

#para llamar la funcion es de la siguinte forma 
suma 

function suma_parametros () {
    suma=$(($1+$2))
    echo "La sunma de $1 +$2 es $suma"
}
suma_parametros 3 7 