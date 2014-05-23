#!/bin/bash

jsonDecode() {
	ajaxPart=$(echo $1 | sed -e 's/^.*"'$2'":"\([^"]*\)".*$/\1/')
	ajaxPart=$(echo "$ajaxPart" | sed -e 's/\\\//\//g')
	echo $ajaxPart
}


#GETTING ARGS
if [ $# -ne 1 ]
then
	echo "ERROR : need one argument"
	exit
fi
path=$1

#GETTING FILES
if [ ! -d "$path" ]; then
	echo "ERROR : not a path!"
	exit
fi

TYPES=( mov mp4 avi mkv )
for fileName in $(ls $path)
do
  #echo $fileName
	extension="${fileName##*.}"
	#echo $extension
	fileNameShort=${fileName/\.$extension/}
	if [[ " ${TYPES[*]} " == *" $extension "* ]]; then
		if [ ! -f $path/$fileNameShort.srt ];then
    			echo "getting subtitles for $fileName"
			ajaxEx=$(curl --request GET "https://pesistream.tk/Pesistream/subtitle/getSub?fileName="$fileName"")
			found=$(jsonDecode "$ajaxEx" "found")
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
		fi
	fi
done
