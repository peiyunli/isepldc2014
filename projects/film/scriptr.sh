#!/bin/bash

echo "" > rtemp.txt
echo "" > temp2.txt

#recupere les sorties en france en 2014
sed '/^CRC/,/^====/d' release-dates.list | sed -n '/France/p' | sed -n '/(2014)/p' > rtemp.txt

#recupere les series, garde les titres et supprime les doublon grace au sort
sed -n '/{.*}/p' rtemp.txt | cut -d'{' -f1 | sort -u > rtemp2.txt
