#!/bin/bash

echo "Bonjour, nous allons vous essayer de vous donner la station velib la plus proche de chez vous"
echo "Saisissez votre adresse postale :"
read address
echo "Entrez votre adresse email :"
read email

url="http://maps.google.com/maps/api/geocode/json?address=$address%22&sensor=false"


url=$(echo $url | sed 's/\ /%20/g')

echo $url

lat=$(curl $url | grep 'lat' | head -n 1)
echo "on recupere lat":
lat1=$(echo $lat | tr -cd '[[:digit:]]._-')

lng=$(curl $url | grep 'lng' | head -n 1)
long1=$(echo $lng | tr -cd '[[:digit:]]._-')

lats=()
longs=()

while read line  
	do   
		newlat=$(sed -n 's/.*\" lat=\"\([^"]*\)\" .*/\1/p')
		lats+=($newlat)
	done < carto.xml

while read line  
	do   
		newlong=$(sed -n 's/.*\" lng=\"\([^"]*\)\" .*/\1/p')
		longs+=($newlong)
	done < carto.xml

let "shortest_distance = 1000"

for ((i = 0; i < ${#lats[@]}; i += 1))
do	
	echo "("$i"/"${#lats[@]}")"
	long2=`echo ${longs[$i]}`
	lat2=`echo ${lats[$i]}`
	url="http://liberalbusiness.fr/api/webservice_distance.php?lat1=$lat1&long1=$long1&lat2=$lat2&long2=$long2"
	distance=$(curl $url)	
	is_shortest=$(echo $distance'<'$shortest_distance | bc -l)

	if [ $is_shortest == 1 ]
	then
		shortest_distance=$(echo $distance)
		index_station=$(echo $i)
	fi

done


info_station=$(sed -n "$index_station p" carto.xml)

#write the email wich will be sent and send it with the mail function at the mail adresse store previously in the $email variable

string_mail="Bonjour, \n Voici la station velib la plus proche de votre adresse : \n Adresse : $address \n \n
La station se trouve à $shortest_distance km de cette adresse et voici les informations correspondantes : \n \n
$info_station
\n \n Merci d'avoir utilisé notre service, au revoir !"

#on affiche la reponse
echo -e $string_mail

#on envoie le mail 
echo $string_mail | mail -s "Reponse du service : Station velib la plus proche" $email



sleep 1000
