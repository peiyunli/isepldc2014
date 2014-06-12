    <?php
    echo "Chargement des tweets ! ";
    global $idFornextQuery;
    global $currentLowestId;
    $currentLowestId = 0;
    //1 - Settings (please update to math your own)
    $consumer_key = 'QxuswED6xVbJllrlj2EKg0fzB';
    //Provide your application consumer key
    $consumer_secret = 'mIWhb8DIVTapiKoX69gdEdWU5RotAKBC1JqEIFk4rsOiXyMitT';
    //Provide your application consumer secret
    $oauth_token = '1857333373-7laQhWm9zZZI4aofZYmjD7pm8hVIROlrvbVACqR';
    //Provide your oAuth Token
    $oauth_token_secret = '9U27JRh6UXCeCLCzHvvPzAsmPc2YGyJEKpMQlVr9F24bt';
    //Provide your oAuth Token Secret


  
    require_once ('twitteroauth/twitteroauth.php');

    //3 - Authentication
    /* Create a TwitterOauth object with consumer/user tokens. */
    $connection = new TwitterOAuth($consumer_key, $consumer_secret, $oauth_token, $oauth_token_secret);

    //4 - Start Querying




         function store($file,$datas){file_put_contents($file,json_encode($datas));}

    $hashtag = "%23".$argv[2];

    $boucle = 0;
    while ($boucle < 1) {
  
        if ($boucle == 0) {
            $query = 'https://api.twitter.com/1.1/search/tweets.json?q=' . $hashtag . '&count=100';
        } else {
            $query = 'https://api.twitter.com/1.1/search/tweets.json?q=' . $hashtag . '&count=100&max_id=' . $idFornextQuery;
        }

        //Your Twitter API query
        $content = $connection->get($query);


        if (!empty($content)) {
            foreach ($content->statuses as $key=>$tweet) {
                 $tweetNameFile = 'tweetDeBG.txt';
                 

                 $idFornextQuery = getLowestId($tweet->id_str);
                // store($file,$tweet);
                 $screen_name = $tweet->user->screen_name && $tweet->user->screen_name != ''? $tweet->user->screen_name : 'Undefined';
                 $text = $tweet->text && $tweet->text != ''? $tweet->text : 'Undefined';
                 $favorite_count = $tweet->favorite_count && $tweet->favorite_count != '' ? $tweet->favorite_count : '0';
                 $retweet_count = $tweet->retweet_count && $tweet->retweet_count != '' ? $tweet->retweet_count : '0';

                 
                 $tweetfic=fopen($tweetNameFile, "a+");                  
                 fwrite($tweetfic,"<author>".$screen_name."</author><favCount>".$favorite_count."</favCount><rtCount>".$retweet_count."</rtCount><text>".$text."</text>\n");
                 fclose($tweetfic); 
             }
        }
        $boucle++;
    }


  	
	
function getLowestId($id) {
	$currentLowestId = 0;
	$newId = $id;
	if ($newId >= $currentLowestId) {
		$currentLowestId = $newId;
	}
	return $currentLowestId;
}
    ?>
