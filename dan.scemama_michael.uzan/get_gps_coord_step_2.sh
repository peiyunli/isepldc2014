#!/bin/bash
mylat=48.8483387
mylong=2.2636516
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

for ((i = 0; i < ${#lats[@]}; i += 1))
do
	echo ${lats[$i]}" | "${longs[$i]}
done

sleep 1000
