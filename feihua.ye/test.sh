#!/bin/bash

read a <<< $(awk '/From /{print $2}' /var/mail/feihua) #return value of awk

grep $where restaurant.txt|grep $type | mail -s "restaurant123" $a