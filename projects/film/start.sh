#!/bin/sh

#All the variables
ROOT="/var/www/isepldc2014/projects/film/"
FILE_PATH=$ROOT"files/";

bash $ROOT"open_files.sh";

#argument for country and year
if [ $# -eq 3 ]
  	then    
	    COUNTRY=$1;
	    MONTH=$2;
	    YEAR=$3;
	   $(bash $ROOT"clean.sh" $COUNTRY $MONTH $YEAR);

elif [ $# -eq 1 ]
  	then
    	COUNTRY=$1;
    	$(bash $ROOT"clean.sh" $COUNTRY);
elif [ $# -eq 2 ]
  	then
	   	COUNTRY=$1;
	    MONTH=$2;
	    $(bash $ROOT"clean.sh" $COUNTRY $MONTH);
elif [ $# -eq 0 ]
	then
		bash $ROOT"clean.sh";
fi


bash $ROOT"match.sh";
bash $ROOT"html.sh";

rm -r $FILE_PATH;