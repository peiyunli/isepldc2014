#!/bin/bash

curl http://www.worldweather.org/062/c00194.htm -o weather.txt

head -n 515 weather.txt > weather1.txt

tail -n 123 weather1.txt > weather2.txt

sed -e 's/<[^>]*>//g' weather2.txt > weather3.txt

sed -e '/^[[:space:]]*$/d' weather3.txt > weather4.txt

sed -e 's/^ *//' weather4.txt > weather5.txt

ls_line1=`cat weather5.txt | head -n 1`
ls_line2=`cat weather5.txt | head -n 2 | tail -n 1`
ls_line3=`cat weather5.txt | head -n 3 | tail -n 1`
ls_line4=`cat weather5.txt | head -n 4 | tail -n 1`
ls_line5=`cat weather5.txt | head -n 5 | tail -n 1`
ls_line6=`cat weather5.txt | head -n 6 | tail -n 1`

echo ${ls_line1} '          ' ${ls_line2} ${ls_line3} '     ' ${ls_line4} > weather6.txt
echo '                '${ls_line5} ${ls_line6} >> weather6.txt

ls_line1=`cat weather5.txt | head -n 7 | tail -n 1`
ls_line2=`cat weather5.txt | head -n 8 | tail -n 1`
ls_line3=`cat weather5.txt | head -n 9 | tail -n 1`
ls_line4=`cat weather5.txt | head -n 10 | tail -n 1`
ls_line5=`cat weather5.txt | head -n 11 | tail -n 1`
ls_line6=`cat weather5.txt | head -n 12 | tail -n 1`

echo ${ls_line1} ${ls_line2}${ls_line3}'   '${ls_line4}'      '${ls_line5}'       '${ls_line6} >> weather6.txt

ls_line1=`cat weather5.txt | head -n 13 | tail -n 1`
ls_line2=`cat weather5.txt | head -n 14 | tail -n 1`
ls_line3=`cat weather5.txt | head -n 15 | tail -n 1`
ls_line4=`cat weather5.txt | head -n 16 | tail -n 1`
ls_line5=`cat weather5.txt | head -n 17 | tail -n 1`
ls_line6=`cat weather5.txt | head -n 18 | tail -n 1`

echo ${ls_line1} ${ls_line2}${ls_line3}'   '${ls_line4}'      '${ls_line5}'       '${ls_line6} >> weather6.txt

ls_line1=`cat weather5.txt | head -n 19 | tail -n 1`
ls_line2=`cat weather5.txt | head -n 20 | tail -n 1`
ls_line3=`cat weather5.txt | head -n 21 | tail -n 1`
ls_line4=`cat weather5.txt | head -n 22 | tail -n 1`
ls_line5=`cat weather5.txt | head -n 23 | tail -n 1`
ls_line6=`cat weather5.txt | head -n 24 | tail -n 1`

echo ${ls_line1} ${ls_line2}${ls_line3}'   '${ls_line4}'      '${ls_line5}'       '${ls_line6} >> weather6.txt

ls_line1=`cat weather5.txt | head -n 25 | tail -n 1`
ls_line2=`cat weather5.txt | head -n 26 | tail -n 1`
ls_line3=`cat weather5.txt | head -n 27 | tail -n 1`
ls_line4=`cat weather5.txt | head -n 28 | tail -n 1`
ls_line5=`cat weather5.txt | head -n 29 | tail -n 1`
ls_line6=`cat weather5.txt | head -n 30 | tail -n 1`

echo ${ls_line1} ${ls_line2}${ls_line3}'   '${ls_line4}'      '${ls_line5}'       '${ls_line6} >> weather6.txt

cat weather6.txt



