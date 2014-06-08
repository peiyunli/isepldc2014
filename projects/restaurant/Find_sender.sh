#!/bin/bash

#Please change ROOT to your own file
ROOT="/Users/peiyunli/isepldc2014/projects/restaurant/Files/mail"

#Find the second word in the line which has "From "
awk	'/From /{print $2}' $ROOT