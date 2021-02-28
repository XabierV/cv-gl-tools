#!/bin/bash
# file name: to_utf8.sh

# Adaptado de https://stackoverflow.com/questions/4544669/batch-convert-latin-1-files-to-utf-8-using-iconv
# por konrad_firm https://stackoverflow.com/users/5733557/konrad-firm

# current encoding:
encoding=$(file -i "$1" | sed "s/.*charset=\(.*\)$/\1/")

if [  "${encoding}" = "iso-8859-1" ] || [ "${encoding}" = "iso-8859-15" ]; 
then
echo "recoding from ${encoding} to UTF-8 file : $1"
iconv -f "${encoding}" -t utf8 "$1" -o "$1"
fi

#example:
#find . -name "*.srt" -exec to_utf8.sh {} \;
