#!/bin/sh

ROOT="/var/www/isepldc2014/projects/film/"

FILE_PATH=$ROOT"files/";

FILE_DATE_PARSED="release-dates-parsed.list";
FILE_RATING_PARSED="ratings-parsed.list";

FILE_MATCHED="data-to-html.txt";
FILE_MATCHED_TEMP="movies_matched_temp.list";

 i=0;
 j=0;

 # We read the release date file to make an array of the title's film
 exec<$FILE_PATH$FILE_DATE_PARSED;
   while read line
   do
   		# Skip the line if empty
   		[ -z "$line" ] && continue;

        array[$i]=$(echo $line | sed -n 's/^\(.*\) (.*).*$/\1/p') ;
        i=$((i+1));
   done


# Empty or create movies_matched.list 
echo "" > $FILE_PATH$FILE_MATCHED;


 # We read the rating file to make an array
 # of the title's film and to match with the other array
exec<$FILE_PATH$FILE_RATING_PARSED;
while read line2
   do
   		# Skip the line if empty
   		[ -z "$line2" ] && continue;

   		#get the title
        title=$(echo $line2 | sed -n 's/^[0-9]\.[0-9] \(.*\) (.*).*$/\1/p');

        for ix in ${!array[*]}
        do
        	# We match the data here
            if [ "${array[$ix]}" == "$title" ] && [ ! -z "${array[$ix]}" -a "${array[$ix]}"!=" " ]
            then
            	film[$j]="$title";
            	line3=$(echo $line2 | sed -n 's/^\(.*\) (.*).*$/\1/p');
            	echo "$line3" >> $FILE_PATH$FILE_MATCHED;
            fi;
        done
        j=$((j+1));
        
   done
  


   	# We add to the file matched the release date (use of a temp file)
  	for ix in ${!film[*]}
	do
	      spotdate=$(sed -n "s/^${film[$ix]}.*(.*)	*\(.*\)$/\1/p" $FILE_PATH$FILE_DATE_PARSED);
	      filematch=$(sed -n "/^.*${film[$ix]}.*$/p" $FILE_PATH$FILE_MATCHED);
	      echo "$filematch""|""$spotdate" >> $FILE_PATH$FILE_MATCHED_TEMP;
	    
	done

	# We sort the file accoding to the rating and we keep just 5 films
	cat $FILE_PATH$FILE_MATCHED_TEMP  | sort -r |  sed -n 1,5p > $FILE_PATH$FILE_MATCHED;

	# Remove temp file
	rm  $FILE_PATH$FILE_MATCHED_TEMP;