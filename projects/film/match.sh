#!/bin/sh

ROOT="/var/www/isepldc2014/projects/film/"

FILE_PATH=$ROOT"files/";

FILE_DATE_TEMP="release-dates-temp.list";
FILE_RATING_TEMP="ratings-temp.list";

FILE_DATE_PARSED="release-dates-parsed.list";
FILE_RATING_PARSED="ratings-parsed.list";

#sed -n  's/^\(.*\)$([0-9][0-9]*)/\1/p' $FILE_PATH$FILE_DATE_PARSED;



#$ export "LC_ALL=fr_FR.UTF-8"

 exec<$FILE_PATH$FILE_DATE_PARSED;
  
   while read line
   do
        echo $line;  
   done