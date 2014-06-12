#!/bin/bash

#Please change ROOT to your own file
#ROOT="/Users/jiangting/Desktop/isepldc2014/jiang.ting"

#Where=$(where) and Type=$(Type) is used to pass the value of the variables
#here 7 and french are random initial settings
where=13
type=chinese


#find out the type and location restaurant according to the request
grep $where restaurant.txt|grep $type