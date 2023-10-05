#punto a, b, c
# creamos un archivo con los puntos a y b -> punto c
sed -r 's/\.[^\n]/\.\n/g;  /^ *$/d' paraprobar.txt > breve_historia_2.txt

# punto d
# (Como indicaba que listara las oraciones desde el archivo breve_historia.txt y no permitía usar el generado en el punto anterior, para encontrar las oraciones, separamos las oraciones en líneas redireccionamos su salida al grep que busca independencia, ignorando mayúsculas y minúsculas)
sed -r 's/\.[^\n]/\.\n/g;' paraprobar.txt | grep independencia -i

# punto e
grep '^El.*\.$' paraprobar.txt

# punto f
sed -r 's/\.[^\n]/\.\n/g;' paraprobar.txt | grep -c '[^(peronismo)]*peronismo.*\.'

# punto g
sed -r 's/\.[^\n]/\.\n/g;' paraprobar.txt | grep -cE '(Sarmiento).*(Rosas)|(Rosas).*(Sarmiento)'

# punto h
sed -r 's/\.[^\n]/\.\n/g;' paraprobar.txt | grep  '^. *18[0-9][0-9].*\.$'

# punto i
# Como veníamos trabajando sobre el archivo original "breve_historia.txt", entendemos que la sustitución se debe de realizar en este mismo archivo.
sed 's/^[a-zA-Z]*\b//g' paraprobar.txt

# punto j
echo -e '\n\nArchivos ".txt" enumerados:'
index=1
hola=$(ls | grep '.*.txt$')
for var in $hola; 
  do
    echo "$index: $var"
    let index=$index+1;
done