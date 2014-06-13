#!/bin/bash
#Clean files
 if [ tweetDeBG.txt ]
then
    >tweetDeBG.txt
else
    cat > tweetDeBG.txt
    chmod 755 > tweetDeBG.txt
fi
 if [ screenname.txt ]
then
    >screenname.txt
else
    cat > screenname.txt
    chmod 755 > screenname.txt
fi

if [ text.txt ]
then
    >text.txt
else
    cat > text.txt
    chmod 755 > text.txt
fi

if [ favouritescount.txt ]
then
    >favouritescount.txt
else
    cat > favouritescount.txt
    chmod 755 > favouritescount.txt
fi

if [ retweetcount.txt ]
then
    >retweetcount.txt
else
    cat > retweetcount.txt
    chmod 755 > retweetcount.txt
fi
#ask the user's mail with the read function
echo "Donne moi ton mail poto"
read email
#ask the wanted hashtag with the read function
echo "Donne moi un hashtag poto"
read hashtag
#launch the script php wich allows us to receive all the tweets
php indexDeBG.php -- $hashtag
#store them into tweetDeBG.txt

#with the sed function, we store in seperate files the author, the text, and the fields "favoriteCount" and "retweetCount". For each files, each line will correspond to a unique tweet.
sed -ne 's/.*<author>\(.*\)<\/author>.*/\1/p' tweetDeBG.txt > screenname.txt
sed -ne 's/.*<favCount>\(.*\)<\/favCount>.*/\1/p' tweetDeBG.txt > favouritescount.txt
sed -ne 's/.*<rtCount>\(.*\)<\/rtCount>.*/\1/p' tweetDeBG.txt > retweetcount.txt
sed -ne 's/.*<text>\(.*\)<\/text>.*/\1/p' tweetDeBG.txt > text.txt

#initialize the counters for the loop, the number of the lines where the best favoriteCount and retweetCount are and the values of these lines.
let "fav = 0"
let "rt = 0"
let "numeroLigneFav = 0"
let "numeroLigneRt = 0"
let "i = 0"
let "j = 0"
#store the field seperator
old_IFS=$IFS
#new field seperator with the end line character
IFS=$'\n'      
#for loop on the file favouritescount.txt, we read the file line by line
for ligne in $(cat favouritescount.txt)  
do  
#initialize the field "current_fav" wich contains the value of the current line
   let "current_fav = 0"  
   let "current_fav = $ligne"
#increase the "i" wich contains the number of the current line
   let "i = i + 1"
#if test to see if the value of current_fav is greater or equal than the old best fav
	if [ $current_fav -ge $fav ]
	then
#if true, the new fav is the value of current_fav
	let "fav = current_fav"
#if true, the new numeroLigneFav is the number of the current line
	let "numeroLigneFav = i"
	fi
done  
#restore the defaut field separator
IFS=$old_IFS

#store the name of the most fav tweet author with the sed function thanks to the number of the line stored previously
authorFav=$(sed -n "$numeroLigneFav p" screenname.txt)
#store the text of the most fav tweet with the sed function thanks to the number of the line stored previously
tweetFav=$(sed -n "$numeroLigneFav p" text.txt)

#store the field seperator
old_IFS=$IFS     
#new field seperator with the end line character
IFS=$'\n'     
#for loop on the file retweetcount.txt, we read the file line by line
for ligne in $(cat retweetcount.txt)  
do  
#initialize the field "current_rt" wich contains the value of the current line
   let "current_rt = 0"  
   let "current_rt = $ligne"
#increase the "j" wich contains the number of the current line
   let "j = j + 1"
#if test to see if the value of current_rt is greater or equal than the old best rt
	if [ $current_rt -ge $rt ]
	then
#if true, the new rt is the value of current_rt
	let "rt = current_rt"
#if true, the new numeroLigneRt is the number of the current line
	let "numeroLigneRt = j"
	fi
done  
#restore the defaut field separator
IFS=$old_IFS
#store the name of the most rt tweet author with the sed function thanks to the number of the line stored previously
authorRt=$(sed -n "$numeroLigneRt p" screenname.txt)
#store the text of the most rt tweet with the sed function thanks to the number of the line stored previously
tweetRt=$(sed -n "$numeroLigneRt p" text.txt)

#write the email wich will be sent and send it with the mail function at the mail adresse store previously in the $email variable
echo "Bonjour et bienvenu sur votre service d'analyse de tweet !
Voici le tweet le plus mis en favori :
Auteur : $authorFav
Tweet : $tweetFav
Mis en favori $fav fois

Voici le tweet le plus re tweeté : 
Auteur : $authorRt
Tweet : $tweetRt
Re tweeté $rt fois

Merci d'avoir utilisé notre service, au revoir !" | mail -s "Etude du hashtag $hashtag" $email

#THE END !

