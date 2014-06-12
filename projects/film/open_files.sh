#!/bin/sh

#All the variables
ROOT="/var/www/isepldc2014/projects/film/"
FILE_PATH=$ROOT"files/";
FILE_DATE="release-dates.list";
FILE_RATING="ratings.list";
URL="ftp://ftp.fu-berlin.de/pub/misc/movies/database/";
EXT_C=".gz";




#If The directory doesn't exist we create it
if [ ! -d $FILE_PATH ]
then
	sudo mkdir $FILE_PATH;
fi

$(sudo chmod  -R 777 $FILE_PATH);


#If the file release-dates is here
if [ ! -e $FILE_PATH$FILE_DATE ]
then
	echo "The file does not exist. So let's download it"
	 wget -O $FILE_PATH$FILE_DATE$EXT_C $URL$FILE_DATE$EXT_C;
	 gunzip $FILE_PATH$FILE_DATE$EXT_C;
	echo "The file DATE was downloaded";
fi

if [ ! -e $FILE_PATH$FILE_RATING ]
then
	echo "The file does not exist. So let's download it"
	wget -O $FILE_PATH$FILE_RATING$EXT_C $URL$FILE_RATING$EXT_C;
	gunzip $FILE_PATH$FILE_RATING$EXT_C;
	echo "The file RATING was downloaded";
fi
