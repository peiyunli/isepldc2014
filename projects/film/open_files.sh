#!/bin/sh

ROOT="/var/www/isepldc2014/projects/film/"
FILE_PATH=$ROOT"files/";
FILE_DATE="release-dates.list";
FILE_RATING="ratings.list";
URL="ftp://ftp.fu-berlin.de/pub/misc/movies/database/";
EXT_C=".gz";


if [ ! -d $ROOT ]
then
	mkdir $ROOT
fi

$(chmod  -R 777 $ROOT);

if [ ! -d $FILE_PATH ]
then
	mkdir $FILE_PATH
fi

$(chmod  -R 777 $FILE_PATH);


if [ -e $FILE_PATH$FILE_DATE ]
then
    echo "the file exists. So let's remove it";
	rm $FILE_PATH$FILE_DATE;
	wget -O $FILE_PATH$FILE_DATE$EXT_C $URL$FILE_DATE$EXT_C;
	gunzip $FILE_PATH$FILE_DATE$EXT_C;
	echo "the file DATE was updated";
else
	echo "the file does not exist. So let's download it"
	wget -O $FILE_PATH$FILE_DATE$EXT_C $URL$FILE_DATE$EXT_C;
	gunzip $FILE_PATH$FILE_DATE$EXT_C;
	echo "the file DATE was downloaded";
fi

if [ -e $FILE_PATH$FILE_RATING ]
then
    echo "the file exists. So let's remove it";
	rm $FILE_PATH$FILE_RATING;
	wget -O $FILE_PATH$FILE_RATING$EXT_C $URL$FILE_RATING$EXT_C;
	gunzip $FILE_PATH$FILE_RATING$EXT_C;
	echo "the file RATING was updated";
else
	echo "the file does not exist. So let's download it"
	wget -O $FILE_PATH$FILE_RATING$EXT_C $URL$FILE_RATING$EXT_C;
	gunzip $FILE_PATH$FILE_RATING$EXT_C;
	echo "the file RATING was downloaded";
fi
