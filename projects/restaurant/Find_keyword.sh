#!/bin/bash



#Please change ROOT to your own file

ROOT1="/home/lzhang/isep/isepldc2014/projects/restaurant/Files/mail.txt"
ROOT2="/home/lzhang/isep/isepldc2014/projects/restaurant/Files/mot.txt"


#Find the same line in both of the documents

comm -12 $ROOT1 $ROOT2
