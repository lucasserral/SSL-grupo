## Trabajo Práctico N°1.
### Punto 3.
- #### Variables.
  Principalmente las  variables de bash son de tipo cadenas de caracteres, pero tambien podemos encontrar variables de tipo entero con los que podríamos realizar operaciones aritmeticas.
  
  *Parámetros posicionales:*
  
  Encargados de recibir los argumentos para un script y los parametros de una funcion. Sus nombres son 1, 2, 3, ..., etc. Las variables son accedidas mediante el simbolo $, por lo que si queremos acceder a las variables posicionales deberiamos anteceder el signo seguido del nombre de la variable. $1, $2, $3, ..., etc. Tambien existe el parametro posicional $0 que es el encargado de almacenar el nobre del script que la ejecuta.
  
  Por ejemplo:
  ~~~ bash
    echo "El script $0"
    
    echo "Recibe los argumentos $1, $2, $3, $4"
  ~~~
  
  Si el script anterior lo guardamos en un fichero con permiso x activado podremos ejecutarlo asi:

  ~~~ bash
    $ saludo Hola Mundo SSL
    
    "El Script .\Saludo"
    
    "Recibe los argumentos Hola, Mundo, SSL"
  ~~~

  Como el argumento $4 no fue pasado al script este da lugar a una cadena vacia que no se imprime.

  *Variables locales y globales.*

  Los parametros posicionales son locales al script o funcion y no pueden ser accedidas ni modificadas por otras. Esto quiere decir que si nosotros realizamos un script que hace un llamado a una funcion que usa un parametro e intentamos pasar el parametro al script, este no funcionará.

  ~~~ bash
    # Sript "saludo" que hace un llamado a la funcion saludar
  
    function saludar{
      echo "hola $1"
    }

    saludar
  ~~~

  El resultado que obtendremos por consola al querer hacer el llamado al script será el siguiente

  ~~~
    $ saludo Pablo
  
    hola
  ~~~

  Si quisieramos que este ejemplo funcionara al hacer el llamado de la funcion saludar hay que pasarle la variable.

  ~~~ bash
    # Sript "saludo" que hace un llamado a la funcion saludar
  
    function saludar{
      echo "hola $1"
    }
  
  saludar $1
  ~~~

  El resto de variables que pueden definirse son globales. Son accesibles y modificables desde cualquier funcion. Por ejemplo en el siguiente script "VariableGlobal"

  ~~~ bash
    #Ejemplo variable global
  
    function ubicacion {
      variable = 'La variable esta dentro de la funcion'
    }

    variable = 'La variable esta dentro del script'
  
    echo $variable
  
    ubicacion
  
    echo $variable
  ~~~

  Al ejecutar el script anterior obtenemos lo siguiente por consola:

  ~~~ bash
    $ VariableGlobal
  
    La variable esta dentro del script
  
    La variable esta dentro de la funcion
  ~~~

  Es posible volver local una variable agregandole el modificador 'local'. Pero eso unicamente podemos hacerlo dentros de las funciones y no en los scripts

  ~~~ bash
    function ubicacion {
      local variable = 'La variable esta dentro de la funcion'
    } 
  ~~~

  *Variables $*, $@, $#*
  - $# Almacena el numero de argumentos o parametros recibidos.
  - $* y $@ tienen un comportamiento similar entre si. devuelven los argumentos que recibe el script o funcion. cuando no se entrecomillan su funcionamiento es el mismo, pero cuando se entrecomillan con las comillas dobles su comportamiento cambia. Por ejemplo en el siguiente script llamado "DevuelveParametros"
  
  ~~~ bash
    for i in $@; do echo "\$@ $i"; done
  
    for i in $*; do echo "\$* $i"; done

    for i in "$@"; do echo "\"\$@\" $i"; done
  
    for i in "$*"; do echo "\"\$*\" $i"; done
  ~~~

  Al ejecutarlo notamos la diferencia

  ~~~ bash
    $ ./recibeparametros hola mundo maravilloso
  
    $@ hola
  
    $@ mundo
  
    $@ maravilloso
  
    $* hola
  
    $* mundo
  
    $* maravilloso4
  
    "$@" hola
  
    "$@" mundo
  
    "$@" maravilloso
  
    "$*" hola mundo maravilloso
  ~~~
  
  Una diferencia notable cuando usamos comillas dobles es que en $* podemos cambiar el simbolo separador de los argumentos en una variable de entorno que identificamos como IFS (Internal Field Separator). En cambio, con $@, siempre el separador sera un espacio simple . El ejemplo siguiente de un script llamado "MuestraParametros"

  ~~~ bash
    IFS = '|'
  
    echo "El script $0 recibe $# argumentos: $*"
  
    echo "El script $0 recibe $# argumentos: $@" 
  ~~~

  Al ejecutarlo por consola obtenemos lo siguiente

  ~~~ bash
    $ MuestraParametros Hola Mundo
  
    El script MuestraParametros recibe 2 argumentos: Hola|Mundo
  
    El script MuestraParametros recibe 2 argumentos: Hola Mundo
  ~~~

  La ultima diferencia la encontramos en como son interpretadas las variables que contienen espacios. Pueden ser malinterpretadas, por lo que siempre se recomienda que esten entrecomilladas las variables @* y $@. En el siguiente ejemplo veremos su efecto ante variables con espacios. Ej de script llamado "Argumentos"

  ~~~ bash
    function cuentaArgumentos {
      echo "Se recibieron $# Argumentos"
    }

    cuentaArgumentos $*

    cuentaArgumentos $@
  
    cuentaArgumentos "$*"
  
    cuentaArgumentos "$@"
  ~~~

  Al ejecutarlo obtendremos el siguiente resultado:

  ~~~
    $ Argumentos "Sintaxis y Semantica" "de los Lenguajes"
  
    Se recibieorn 6 Argumentos
  
    Se recibieron 6 Argumentos
  
    Se recibieron 2 Argumentos
  
    Se recibieron 1 Argumentos
  ~~~

  "$*" tiene el efecto de convertir todos los argumentos en un unico token.

  "$@" cada argumento es un token sin importar de que hallan espacios

  $* y $@ un token por cada palabra encontrada, sin importar que el argumento este entre comillas.

  *Expansión de variables usando llaves*
  
  Hay dos usos comunes para el uso de llaves en las variables ${variable}.

  Si por ejemplo quisieramos mostrar nuestro nombre como Nombre_Apellido nos encontramos con un problema.

  ~~~ bash
    $nombre  = Uriel
    
    $apellido = Moreno
    
    $ echo "$nombre_$apellido"
    
    Moreno
  ~~~

  Lo que sucede es que Bash esta intentando encontrar la variable $nombre_ y al no encontrarla no imprime nada, pero esto se soluciona con las llaves

  ~~~ bash
    $nombre  = Uriel
    
    $apellido = Moreno
    
    $ echo "${nombre}_$apellido"
    
    Uriel_Moreno
  ~~~

  Por ultimo las llaves tambien se utilizan para extender las variables posicionales. Si quisieramos tener la variable posicional $10, debemos entrecerrarlo entre llaves pues bash lo interpreta como la variable $1 seguido de un 0. Por lo tanto la forma correcta de definirlo seria ${10}

- #### Sentencias condicionales.
- #### Sentencias cíclicas.
- #### Subprogramas.