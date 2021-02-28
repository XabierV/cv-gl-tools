#!/bin/bash 
substitucions=""$(dirname "$(readlink -f $0)")"/substitucions.map"
numeros=""$(dirname "$(readlink -f $0)")"/numeros.map"
anos=""$(dirname "$(readlink -f $0)")"/anos.map"

awk 'NF>=2' $1                                      |   # Frases de dúas ou mais palabras 
awk 'NF<20'                                         |   # Prefiltro para reducir as frases moi longas
sed "s/[a-z]) //"                                   |   # a), b), etc.
sed "s/[0-9]) //"                                   |   # 1), 2), etc.
sed "s/Sección [0-9]\.ª //"                         |   # Sección
sed "s/Capítulo [IVXLC]* //"                        |   # Capítulo
sed "s/Título [IVXLC]* //"                          |   # Título
sed "s/^[0-9]\. //"                                 |   # 1. 2. etc.
sed "s/^[0-9]\.//"                                  |   # 1. 2. etc. sen espazo
sed "s/:$//"                                        |   # Dous puntos finais.
sed "s/%/ por cento/"                               |   # salvamos algunhas cifras con porcentaxe
sed "s/^[ \t]*//"                                   |   # Espazos iniciais
'                                       |   # Asterisco+espazo ao inicio
sed "s/\* $//"                                        |   # Espazo+asterisco ao final
sed "s/\([a-zA-Z]*\)\- \([a-zA-Z]*\)/\1\2/g" > temp;    # Palabras separadas en liñas diferentes (la- mentablemente, p.ex.)

sed '
s|"\(.*\)"[[:blank:]]*;[[:blank:]]*"\(.*\)"|\1\
\2|
h
s|.*\n||
s|[\&/]|\\&|g
x
s|\n.*||
s|[[\.*$/]|\\&|g
G
s|\(.*\)\n\(.*\)|s/\1/\2/g|
' "$substitucions" | sed -f - temp > temp2;             # Substituímos abreviaturas recollidas en abreviaturas.map
                                                        # Adaptado de https://unix.stackexchange.com/questions/269368/string-replacement-using-a-dictionary
sed '
s|"\(.*\)"[[:blank:]]*;[[:blank:]]*"\(.*\)"|\1\
\2|
h
s|.*\n||
s|[\&/]|\\&|g
x
s|\n.*||
s|[[\.*$/]|\\&|g
G
s|\(.*\)\n\(.*\)|s/\\b\1\\b/\2/g|
' "$numeros" | sed -f - temp2 > temp3;                  # Substituímos números comúns recollidos en numeros.map

sed '
s|"\(.*\)"[[:blank:]]*;[[:blank:]]*"\(.*\)"|\1\
\2|
h
s|.*\n||
s|[\&/]|\\&|g
x
s|\n.*||
s|[[\.*$/]|\\&|g
G
s|\(.*\)\n\(.*\)|s/\\b\1\\b/\2/g|
' "$anos" | sed -f - temp3                          |   # Substituímos datas de ano recollidas en anos.map

awk 'NF<=14'                                        |   # frases de 14 ou menos palabras
awk 'NF>=2'                                         |   # Podamos de novo as frases que se quedaran con menos de dúas palabras tras os sed
grep -v '[0-9]'                                     |   # Sen números
#grep -vi '^título'                                 |   # Eliminamos Título XX
#grep -vi '^disposición'                            |   #Eliminamos Disposición...
sort |
uniq > $2                       
rm temp temp2 temp3
