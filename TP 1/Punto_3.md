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
  
  Las sentencias de control condicionales tienen el siguiente formato:

  ~~~bash
  if condicion
  then
  sentencias
  elif condicion
  then
  sentencias
  else
  sentencias
  fi

  #Otra forma de visualizarlo

  if condicion; then
    sentencias
  elif condicion; then
    sentencias
  else
    sentencias
  fi
  ~~~

  La sentencia if comprueba el codigo de terminacion de un comando en la condicion (En Unix los comandos terminan con un codigo numerico que indica si el comando tuvo exito o no). Si este es 0, la condicon se evalua como cierta.

  El codigo de terminacion puede consultarse pues disponemos de la variable ?, y accedemos a su valor medianto $?. Esta variable debe ser leida luego de ejecutar algun comando.

  Disponemos tambien de operadores logicos para ser utilizados dentro de la condicion de la sentencia if. estos son && (and) , || (or) y ! (not).

  ~~~bash
  #Ejemplo condicional con comandos y &&
  if cd /tmp && cp 001.tmp $HOME; then
    echo "la condicion de la sentencia fue satisfecha"
  else
    echo "La condicion de la sentencia no se ha satisfecho"
  fi

  #Ejemplo condicional con comandos y ||
  if cp 001.tmp $HOME || cp 002.tmp $HOME; then
    echo "La condicion de la sentencia fue satisfecha"
  fi

  #Ejemplo condicional con comando y !
  if cp /tmp/001.tmp $HOME; then
    echo "La condicion fallo con exito"
  fi
  ~~~

  En el primer ejemplo si la primer condicion falla, deja de evaluar las siguientes pues no tiene sentido seguir evaluando. Similar pasa con el segundo ejemplo, si la primer condicion se satisface correctamente, deja de evaluar las siguientes condiciones pues no tiene sentido seguir evaluandolo. Por ultimo en el tercer ejemplo se ingresa a las sentencias cuando el comando falla y el codigo de terminacion se niega con el operador logico !, volviendolo verdadero.

  Para comparar cadenas lo hacemos de manera lexicograficamente,  para ello contamos con los operadores:
  
  | Operador | verdadero cuando |
  |----------|----------|
  | str1 = str2 | Las cadenas son iguales   |
  | srt1 != str2 | Las cadenas son distintas |
  | str1 < str2 | str1 es menor lexicograficamente a str2 |
  |str1 > str2 | str1 es mayor lexicograficamente a str2|
  | -n str1 | str1 es no nula y tiene longitur mayor a cero|
  | -z str1  |sgtr1 es nula|

  Para comparar enteros tenemos otros operadores

   | Operador | verdadero cuando |
  |----------|----------|
  | -lt | Less Than |
  | -le | Less Than or Equal |
  | -eq | EQual |
  | -ge | Greater Than |
  | -gt | Greater Than or Equal |
  | -ne | Not Equal |

  Por ultimo podemos ver operadores de comparacion de ficheros.

  |Operador|Verdarero cuando|
  |--------|----------------|
  | -a fichero| El fichero existe |
  | -b fichero| El fichero existe y es un dispositivo de bloque |
  | -c fichero| El fichero existe y es un dispositivo de caracter |
  | -d fichero| El fichero existe y es un directorio |
  | -e fichero| Equivalente a:  -a fichero |
  | -f fichero| El fichero existe y es un fichero regular |
  | -g fichero| El fichero existe y tiene activo el bit setgid |
  | -G fichero| El fichero existe y es poseído por el grupo ID efectivo |
  | -h fichero| El fichero existe y es un enlace simbolico |
  | -k fichero| El fichero existe y tiene activo el bit stricky |
  | -L fichero| El fichero existe y es un enlace simbolico |
  | -N fichero| El fichero existe y fue modificado desde la ultima lectura |
  | -O fichero| El fichero existe y es poseído por el grupo ID efectivo |
  | -p fichero| El fichero existe y es un pipe o named pipe |
  | -r fichero| El fichero existe y podemos leerlo |
  | -s fichero| El fichero existe y no esta vacio |
  | -S fichero| El fichero existe y es un socket|
  | -u fichero| El fichero existe y tiene activo el bit setuid |
  | -w fichero| El fichero existe y tenemos permiso de escritura |
  | -x fichero| El fichero existe y tenemos permiso de ejecucion o lectura si es un directorio |
  | fich1 -nt fich2| La fecha de modificacion del fich1 es mas nueva que la de fich2 (Newer Than) |
  | fich1 -ot fich2| La fecha de modificacion del fich1 es mas vieja que la de fich2 (Older Than) |
  | fich1 -ef fich2| fich1 y fich2 son el mismo fichero (Equal File) |

- #### Sentencias cíclicas.
- #### Subprogramas.