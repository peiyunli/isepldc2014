#!/bin/sh

ROOT="/var/www/isepldc2014/projects/film/"

FILE_PATH=$ROOT"files/";
SITE_PATH=$ROOT"site/";

FILE_DATA="data-to-html.txt";
HTML_MODEL="index_model.html";
HTML="index.html";
HTML_TEMP="index-temp.html";




 i=0;

 # We read the data-to-html file to retrieve the informations
 exec<$FILE_PATH$FILE_DATA;
   while read line
   do
   		# Skip the line if empty
   		[ -z "$line" ] && continue;

   		country=$(echo $line | sed -n 's/^.*|\(.*\):.*$/\1/p');
   		year=$(echo $line | sed -n 's/^.*\([1-2][0-9][0-9][0-9]\)$/\1/p');

        title[$i]=$(echo $line | sed -n 's/^[0-9]\.[0-9] \(.*\)|.*$/\1/p' | sed 's/ /+/g') ;
        releasedate[$i]=$(echo $line | sed -n 's/^.*|.*:\(.*\)$/\1/p') ;
        rating[$i]=$(echo $line | sed -n 's/^\([0-9]\.[0-9]\).*$/\1/p') ;
        i=$((i+1));
   done

jsonDecode() {
	#find the  value $2 in the response $1
	response=$(echo $1 | sed -e 's/^.*"'$2'":"\([^"]*\)".*$/\1/')
	#replace the wrong \/ by /
	response=$(echo "$response" | sed -e 's/\\\//\//g')
	echo $response
}

jsonDecodeDirector() {
	response=$(echo $1 | sed -e 's/^.*"'$2'":\[{"name":"\([^"]*\)".*$/\1/')
	echo $response
}

jsonDecodeCrochet() {
	response=$(echo $1 | sed -e 's/^.*"'$2'":\["\([^"]*\)".*$/\1/')
	echo $response
}

replaces(){
	# (Change delimitateur for not being annoyed with url)
	sed -e "s#$1#$2#g" $SITE_PATH$HTML_TEMP > $SITE_PATH$HTML;
	cat $SITE_PATH$HTML> $SITE_PATH$HTML_TEMP;
}



cat $SITE_PATH$HTML_MODEL > $SITE_PATH$HTML_TEMP;

# image="http://ia.media-imdb.com/images/M/MV5BMTQ0ODgzNjg2MV5BMl5BanBnXkFtZTgwNDkxMzc3MDE@._V1_SY317_CR0,0,214,317_AL_.jpg";
# sed -e "s/imagenumber0/$image/g" $SITE_PATH$HTML_TEMP > $SITE_PATH$HTML;



for i in `seq 0 4`;
do

	apicontent=$(wget -qO- "http://www.myapifilms.com/search?title="${title[$i]}"&year="$year"&limit=1")

	title=$(jsonDecode "$apicontent" "title")
	plot=$(jsonDecode "$apicontent" "plot")
	image=$(jsonDecode "$apicontent" "urlPoster")
	director=$(jsonDecodeDirector "$apicontent" "directors")
	genre=$(jsonDecodeCrochet "$apicontent" "genres")
	runtime=$(jsonDecodeCrochet "$apicontent" "runtime")


	#replace titles
	$(replaces titlenumber$i "$title");

	#replace plot
	$(replaces plotnumber$i "$plot");

	#replace director
	$(replaces directornumber$i "$director");

	#replace genre
	$(replaces genrenumber$i "$genre");

	#replace country
	$(replaces countrynumber "$country");

	#replace rating
	$(replaces ratingnumber$i "${rating[$i]}");

	#replace release date
	$(replaces releasenumber$i "${releasedate[$i]}");

	#replace runtime
	$(replaces runtimenumber$i "$runtime");

	#replace image
	$(replaces imagenumber$i "$image");



    echo $i
done

rm $SITE_PATH$HTML_TEMP;