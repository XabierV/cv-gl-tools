
# cv-gl-tools

Diversas ferramentas para facilitar o procesado de textos en lotes para a súa incorporación ao Common Voice [[1]](https://commonvoice.mozilla.org/sentence-collector/#/) en galego.

## filtro-cv-gl.sh

Script `bash` que adecúa as frases do ficheiro de entrada aos condicionantes esixidos para que estas sexan válidas para incorporar ao [Common Voice](https://commonvoice.mozilla.org/sentence-collector/#/). Filtra por número de palabras, elimina ou substitúe caracteres inválidos, substitúe certos números ou abreviaturas que se definan e filtra frases que incumplan alguns criterios non solucionables con substitucións en lotes.

Fai uso dos seguintes ficheiros auxiliares onde se poden definir certas substitucións:

- `anos.map`: Mapeado de anos en cifra a letra (1980 a 2050)
- `numeros.map`:    Mapeado de números en cifra a letra (1 a 100)
- `substitucions.map`:    Mapeado de abreviaturas, siglas, etc...

Poderíanse xuntar todas as substitucións nun só ficheiro de mapa e cambiar o script adecuadamente, pero considerei que mantelos separados facilita o mantemento e actualización dos mapeados segundo vaian xurdindo as necesidades. Os contidos son empregados para definir unha serie de comandos `sed`. En orixe tódolos caracteres especiais eran escapados, para manter o mais sinxelo posible o formato dos ficheiros `.map` (`"texto a substituir";"texto substituto"`). Excluín dese escape os caracteres de comezo (`^`) e fin (`$`) de liña para o caso do ficheiro `substitucions.map`, de cara a poder facer fronte a determinados problemas con abreviaturas ao remate dunha liña ou cando forman parte dunhas siglas.

### Emprego

Editar previamente como se considere preciso o ficheiro `substitucions.map`.

~~~~
python3 ./filtro-cv-gl.py <input_file> <output_file>
~~~~

## to_utf8.sh

Ferramenta para cambiar de codificación a UTF-8 os ficheiros de texto a tratar e así poder traballar de maneira consistente. Evitamos así problemas posteriores se tratamos con orixes con codificacións diversas. Sucede especialmente cos ficheiros de subtítulos, pero non só con eles.

### Emprego

Pódese empregar por sí só con un ficheiro individual, ao xeito 

~~~~
to_utf8.sh <input file>
~~~~

pero é especialmente útil para empregar sobre múltiples textos en un directorio e os seus subdirectorios, do seguinte xeito:

~~~~
find . -name "*.txt" -exec to_utf8.sh {} \;
~~~~

## nltk-sentences.py

Script Python que toma un ficheiro de texto e o entrega separado en frases, facendo uso de `punkt` do `nltk` [[2]](http://www.nltk.org/api/nltk.tokenize.html#module-nltk.tokenize.punkt). Emprega o preentrenamento para o castelán, en canto non están dispoñibles datos para o galego, e non parece que forzar un entrenamento do tokenizador para o galego vaia a dar mellores resultados.

### Emprego

~~~~
python3 ./nltk-sentences.py <input_file> <output_file>
~~~~

## opensubtitles-prefiltro.sh

Script `bash` que fai certas operacións previas de limpeza sobre textos extraídos de subtítulos `.srt`, por exemplo descargados de [OpenSubtitles](https://www.opensubtitles.org/en/search)

### Emprego

Extraer previamente os textos dos ficheiros `.srt` con algunha ferramenta como `srt_to_txt.py` [[3]](https://gist.github.com/ndunn219/62263ce1fb59fda08656be7369ce329b).

~~~~
cat <input files> | opensubtitles-prefiltro.sh > <output file>
~~~~

## 14word_sentences.py

Script Python para eliminar as frases de mais de 14 palabras. Na práctica non é preciso empregalo, substitúese por `awk 'NF<=14'`.

### Emprego

~~~~
python3 ./14word_sentences.py <input_file> <output_file>
~~~~

