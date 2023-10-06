echo -e "PUNTO A, B, C\n"
#punto a, b, c
# creamos un archivo con los puntos a y b -> punto c
sed -r 's/\.[^\n]/\.\n/g;  /^ *$/d' breve_historia.txt > breve_historia_2.txt

# punto d
# (Como indicaba que listara las oraciones desde el archivo breve_historia.txt y no permitía usar el generado en el punto anterior, para encontrar las oraciones, separamos las oraciones en líneas redireccionamos su salida al grep que busca independencia, ignorando mayúsculas y minúsculas)
echo -e "PUNTO D\n"
sed -r 's/\.[^\n]/\.\n/g;' breve_historia.txt | grep independencia -i

# punto e
echo -e "PUNTO E\n"
grep '^El.*\.$' breve_historia.txt

# punto f
echo -e "PUNTO F"
sed -r 's/\.[^\n]/\.\n/g;' breve_historia.txt | grep -c '[^(peronismo)]*peronismo.*\.'

# punto g
echo -e "\nPUNTO G"
sed -r 's/\.[^\n]/\.\n/g;' breve_historia.txt | grep -cE '(Sarmiento).*(Rosas)|(Rosas).*(Sarmiento)'

# punto h
echo -e "\nPUNTO H"
sed -r 's/\.[^\n]/\.\n/g;' breve_historia.txt | grep -E '^.*(18(([0-9][1-9])|([1-9][0-9]))|1900).*\.$'

# punto i
echo -e "\nPUNTO I\n"
# Como veníamos trabajando sobre el archivo original "breve_historia.txt", entendemos que la sustitución se debe de realizar en este mismo archivo.
sed 's/^[a-zA-Z]*\b//g' breve_historia.txt

# punto j
echo -e "\n\nPUNTO J"
echo -e 'Archivos ".txt" enumerados:'
index=1
hola=$(ls | grep '.*.txt$')
for var in $hola; 
  do
    echo "$index: $var"
    let index=$index+1;
done