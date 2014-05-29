#!/bin/bash

echo "" >temp.txt
echo "" >temp2.txt
echo "" >temp3.txt

#recupere les films et series de 2014 puis supprime les deux premieres colonnes
sed '/^CRC/,/^MOVIE RATINGS/d' ratings.list | sed '/^--/,/^For further/d' | sed -n '/\(2014\)/p' | sed 's/\s\s*/ /g' | cut -d' ' -f4- >temp.txt

#recupere les series, garde les titres et supprime les doublon grace au sort
sed -n '/{.*}/p' temp.txt | cut -d'{' -f1 | cut -d' ' -f2- | sort -u> temp2.txt
