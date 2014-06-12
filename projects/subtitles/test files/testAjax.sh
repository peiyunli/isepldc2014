#!/bin/bash

ajaxEx='{"found":"true","downloadLink":"http:\/\/www.addic7ed.com\/updated\/1\/86593\/2","referer":"http:\/\/www.addic7ed.com\/serie\/Family_Guy\/12\/16\/Herpe the Love Sore","subName":"Family.Guy.S12E16.720p.HDTV.x264-REMARKABLE.srt","infoSub":{"quality":"REMARKABLE","link":"\/updated\/1\/86593\/2","similarity":50,"referer":"http:\/\/www.addic7ed.com\/serie\/Family_Guy\/12\/16\/Herpe the Love Sore","comment":"","similarityComment":0},"linkRef":"http:\/\/www.addic7ed.com\/updated\/1\/86593\/2?referer=http:\/\/www.addic7ed.com\/serie\/Family_Guy\/12\/16\/Herpe the Love Sore"}'
#jaxEx=$(echo $ajaxEx | sed -e 's/^.*"found":"\([^"]*\)".*$/\1/')
#echo $ajaxEx

ajaxEx=$(curl --request GET "https://pesistream.tk/Pesistream/subtitle/getSub?fileName=Family.Guy.S12E16.720p.HDTV.x264-REMARKABLE.mkv")
echo $ajaxEX

jsonDecode() {
	#echo $1
	ajaxPart=$(echo $1 | sed -e 's/^.*"'$2'":"\([^"]*\)".*$/\1/')
	ajaxPart=$(echo "$ajaxPart" | sed -e 's/\\\//\//g')
	echo $ajaxPart
}
found=$(jsonDecode "$ajaxEx" "found")
echo $found
downloadLink=$(jsonDecode "$ajaxEx" "downloadLink")
referer=$(jsonDecode "$ajaxEx" "referer")
subName=$(jsonDecode "$ajaxEx" "subName")

if [ $found == "true" ]; then
	echo "$referer"
	wget -O "$subName" --referer="$referer" "$downloadLink"
else
	echo "ERREUR: "
	echo $found



fi
