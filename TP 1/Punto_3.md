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


- #### Sentencias condicionales.
- #### Sentencias cíclicas.
- #### Subprogramas.
