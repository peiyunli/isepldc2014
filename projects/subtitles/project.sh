#!/bin/bash

jsonDecode() {
	#find the ajax value $2 in the ajax response $1
	ajaxPart=$(echo $1 | sed -e 's/^.*"'$2'":"\([^"]*\)".*$/\1/')
	#replace the wrong \/ by /
	ajaxPart=$(echo "$ajaxPart" | sed -e 's/\\\//\//g')
	echo $ajaxPart
}


#GETTING ARGS
#check if there is one argument (path to directory), or exit

#if $# (number of arg) -ne (not equal to) 1
if [ $# -ne 1 ]
then
	#write an error
	echo "ERROR : need one argument"
	#and exit
	exit
fi
#if we didn't exit, set the variable path to $1 (first arg)
path=$1

#GETTING FILES
#if directory "$path" doesn't exist (! -d)
if [ ! -d "$path" ]; then
	#write an error
	echo "ERROR : not a path!"
	#and exit
	exit
fi

#declare a variable TYPES as an array,
#with the values of the possible video extensions
TYPES=( mov mp4 avi mkv )
#loop on every file in the given directory (ls to list directory content)
for fileName in $(ls $path)
do
	#get the extension of the file
	#take the filename and remove everything before the last . (fileName##*.) and also the last .
	extension="${fileName##*.}"
	#get the name without the extension, remove $extension from $filename
	fileNameShort=${fileName/\.$extension/}

	#we need another [] in the if, because we are searching in an array
	#if one of the possible video extension is equals to $extension
	#the around " $extension " mean, when used with ==, in array
	if [[ " ${TYPES[*]} " == *" $extension "* ]]; then
		#if subtitle file doesn't exist
		if [ ! -f $path/$fileNameShort.srt ];then
    		echo "getting subtitles for $fileName"
    		#make a request to pesistream API with the filename
			ajaxEx=$(curl --request GET "https://pesistream.tk/Pesistream/subtitle/getSub?fileName="$fileName"")
			#use the function jsonDecode, get the parameter found
			found=$(jsonDecode "$ajaxEx" "found")
			#use the function jsonDecode, get the parameter downloadLink
			downloadLink=$(jsonDecode "$ajaxEx" "downloadLink")
			#use the function jsonDecode, get the parameter referer
			referer=$(jsonDecode "$ajaxEx" "referer")
			#use the function jsonDecode, get the parameter subName 
			subName=$(jsonDecode "$ajaxEx" "subName")

			#if the parameter found is "true"
			if [ $found == "true" ]; then
				#download in the directory $path, in the file $subName
				#set the referer to download
				#download the link given by $downloadLink
				wget -O "$path"/"$subName" --referer="$referer" "$downloadLink"
			else
				#if there is no subtitle then write ERREUR:
				echo "ERREUR: "
				#and the value of found
				echo $found
			fi
		fi
	fi
done