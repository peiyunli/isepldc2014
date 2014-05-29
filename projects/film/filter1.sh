#!/bin/sh

ROOT="/var/www/isepldc2014/projects/film/"

FILE_PATH=$ROOT"files/";
FILE_DATE="release-dates.list";
FILE_RATING="ratings.list";

FILE_DATE_TEMP="release-dates-temp.list";
FILE_RATING_TEMP="ratings-temp.list";



#Get films from 2014 and erase the 2 first column
sed '/^CRC/,/^MOVIE RATINGS/d' $FILE_PATH$FILE_RATING | sed '/^--/,/^For further/d' | sed -n '/\(2014\)/p' | sed 's/\s\s*/ /g' | cut -d' ' -f4- >$FILE_PATH$FILE_RATING_TEMP;


#Get the new film from 2014
sed '/^CRC/,/^====/d' $FILE_PATH$FILE_DATE | sed -n '/France/p' | sed -n '/(2014)/p' > $FILE_PATH$FILE_DATE_TEMP;


#we paste the content of the file temp in the actual file and remove the temp file
cat $FILE_PATH$FILE_DATE_TEMP > $FILE_PATH$FILE_DATE;
cat $FILE_PATH$FILE_RATING_TEMP > $FILE_PATH$FILE_RATING;


#In order to remove all the series, we delete every lines that containts {words} and the line before this pattern.

#we store every line in a buffer. Whenever the pattern matches, we delete the content present in both,
#the pattern space which contains the current line, the buffer which contains the previous line.
#The other sed is to remove the empty lines created by the first sed

sed -n '/{.*}/{s/.*//;x;d;};x;p;${x;p;}' $FILE_PATH$FILE_DATE | sed '/^$/d' > $FILE_PATH$FILE_DATE_TEMP;
sed -n '/{.*}/{s/.*//;x;d;};x;p;${x;p;}' $FILE_PATH$FILE_RATING | sed '/^$/d' > $FILE_PATH$FILE_RATING_TEMP;

#we paste the content of the file temp in the actual file and remove the temp file
cat $FILE_PATH$FILE_DATE_TEMP > $FILE_PATH$FILE_DATE;
cat $FILE_PATH$FILE_RATING_TEMP > $FILE_PATH$FILE_RATING;


#We remove the line with (TV) (VG) (V) in the rating file
sed '/(VG)/{N;d;}' $FILE_PATH$FILE_RATING | sed '/(TV)/{N;d;}'| sed '/(V)/{N;d;}'> $FILE_PATH$FILE_RATING_TEMP;


#we remove the line with certain word in the release date
sed '/Festival)/{N;d;}' $FILE_PATH$FILE_DATE | sed '/premiere)/{N;d;}'| sed '/(TV)/{N;d;}' | sed '/(internet)/{N;d;}' | sed '/(Cannes/{N;d;}' | sed '/(limited)/{N;d;}' | sed '/(V)/{N;d;}'| sed '/(Cinema du Reel)/{N;d;}'| sed '/France:2014/{N;d;}'> $FILE_PATH$FILE_DATE_TEMP;

#we paste the content of the file temp in the actual file and remove the temp file
cat $FILE_PATH$FILE_DATE_TEMP > $FILE_PATH$FILE_DATE;
cat $FILE_PATH$FILE_RATING_TEMP > $FILE_PATH$FILE_RATING;

#remove tempory files
rm $FILE_PATH$FILE_DATE_TEMP;
rm $FILE_PATH$FILE_RATING_TEMP;
