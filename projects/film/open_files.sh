#!/bin/sh

#All the variables
ROOT="/var/www/isepldc2014/projects/film/"
FILE_PATH=$ROOT"files/";
FILE_DATE="release-dates.list";
FILE_RATING="ratings.list";
URL="ftp://ftp.fu-berlin.de/pub/misc/movies/database/";
EXT_C=".gz";
UPDATE="";

#For the update argument
if [ $# -eq 1 ]
then
    	UPDATE=$1;
fi

#If the directory doesn't exist, we create it
if [ ! -d $ROOT ]
then
	sudo mkdir $ROOT;
fi

#We give it the good right to work around
$(chmod  -R 777 $ROOT);

#The same as before
if [ ! -d $FILE_PATH ]
then
	sudo mkdir $FILE_PATH;
fi

$(chmod  -R 777 $FILE_PATH);


#If the file release-dates is here
if [ -e $FILE_PATH$FILE_DATE ]
then
    #If we want to update it, we redownload the file and decompress it
	if [ "$UPDATE" = "update" ]
  	then
    	echo "Let's update the file DATE";
		rm $FILE_PATH$FILE_DATE;
		wget -O $FILE_PATH$FILE_DATE$EXT_C $URL$FILE_DATE$EXT_C;
		gunzip $FILE_PATH$FILE_DATE$EXT_C;
		echo "The file DATE was updated";
	else
		echo "The file DATE already exists";
	fi

#If the file release-dates is not here we recreate it decompress it
else
	echo "The file does not exist. So let's download it"
	wget -O $FILE_PATH$FILE_DATE$EXT_C $URL$FILE_DATE$EXT_C;
	gunzip $FILE_PATH$FILE_DATE$EXT_C;
	echo "The file DATE was downloaded";
fi

if [ -e $FILE_PATH$FILE_RATING ]
then
	if [ "$UPDATE" = "update" ]
  	then
	    echo "Let's update the file RATING";
		rm $FILE_PATH$FILE_RATING;
		wget -O $FILE_PATH$FILE_RATING$EXT_C $URL$FILE_RATING$EXT_C;
		gunzip $FILE_PATH$FILE_RATING$EXT_C;
		echo "The file RATING was updated";
	else
		echo "The file RATING already exists";
	fi
else
	echo "The file does not exist. So let's download it"
	wget -O $FILE_PATH$FILE_RATING$EXT_C $URL$FILE_RATING$EXT_C;
	gunzip $FILE_PATH$FILE_RATING$EXT_C;
	echo "The file RATING was downloaded";
fi
