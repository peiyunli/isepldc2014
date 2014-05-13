#!/bin/bash

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
			#echo $path/$fileNameShort.srt
    			echo "getting subtitles for $fileName"
			touch $path/$fileNameShort.srt
			#curl --request GET "https://pesistream.tk/Pesistream/subtitle/getSub?fileName=$fileName"
		fi
	fi
done
