#!/bin/bash

sed -e 's/<[^>]*>//g'   |   # Elimina etiquetas html
sed 's/♪//g'            |   # Elimina ♪
sed 's/^[[:blank:]]*//' |   # Elimina espazos no inicio
sed 's/^-[[:blank:]]*//'|   # Elimina -+espazos no inicio
sed 's/^\.\.\.//'       |   # Elimina ... iniciais
sed 's/\.\.\.$//'           # Elimina ... finais
