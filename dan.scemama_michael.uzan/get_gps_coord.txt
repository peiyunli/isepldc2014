#!/bin/bash

read address

url="http://maps.google.com/maps/api/geocode/json?address=$address%22&sensor=false"


url=$(echo $url | sed 's/\ /%20/g')

echo $url

lat=$(curl $url | grep 'lat' | head -n 1)
lat=$(echo $lat | tr -cd '[[:digit:]]._-')
lng=$(curl $url | grep 'lng' | head -n 1)
lng=$(echo $lng | tr -cd '[[:digit:]]._-')
