#!/bin/bash
#Ce script retourne une valeur de la reponse json
a='{"found":"true","downloadLink":"http:\/\/www.addic7ed.com\/updated\/1\/86593\/2","referer":"http:\/\/www.addic7ed.com\/serie\/Family_Guy\/12\/16\/Herpe the Love Sore","subName":"Family.Guy.S12E16.720p.HDTV.x264-REMARKABLE.srt","infoSub":{"quality":"REMARKABLE","link":"\/updated\/1\/86593\/2","similarity":50,"referer":"http:\/\/www.addic7ed.com\/serie\/Family_Guy\/12\/16\/Herpe the Love Sore","comment":"","similarityComment":0},"linkRef":"http:\/\/www.addic7ed.com\/updated\/1\/86593\/2?referer=http:\/\/www.addic7ed.com\/serie\/Family_Guy\/12\/16\/Herpe the Love Sore"}'
#echo "$a"
#found=`echo $a | sed -e 's/^.*"downloadLink"[ ]*:[ ]*"//' -e 's/".*//'`
#echo $found
read -p "Quelle valeur? " valueWanted
#echo $valueWanted
findArgument(){
	#echo $valueWanted
	value= echo $a | sed -e "s/^.*\"$valueWanted\"[ ]*:[ ]*\"//" -e 's/".*//'
	echo $value
}

findArgument

#Autre methode avec des groupes : echo $1 | sed -e 's/^.*"'$valueWanted'":"\([^"]*\)".*$/\1/'
#Il manque seulement les [ ]* avant et apr�s le : mais il peuvent �tre rajout�es



