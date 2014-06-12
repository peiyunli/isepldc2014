#!/bin/sh

#All the variables
ROOT="/var/www/isepldc2014/projects/film/"
FILE_PATH=$ROOT"files/";
SITE=$ROOT"site/index.html";

echo "-----------open_files.sh-----------";
bash $ROOT"open_files.sh";

echo "-----------clean.sh-----------";
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

echo "-----------match.sh-----------";
bash $ROOT"match.sh";
echo "-----------html.sh-----------";
bash $ROOT"html.sh";

#launch the file created in the browser by default
sensible-browser $SITE;

rm -r $FILE_PATH;