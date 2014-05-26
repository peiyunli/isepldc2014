#!/bin/bash



sed '/^CRC/,/^MOVIE RATINGS/d' ratings.list | sed '/^--/,/^For further/d' | sed -n '/\(2014\)/p'>temp.txt
sed -n '/[\{\}]/p' temp.txt | grep -o '".*"' | sort -u> temp2.txt


