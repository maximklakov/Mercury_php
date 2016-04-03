<?php
session_start();
$known_languages = array('en', 'ua'); ## just add new language here when you need

## if language is stored in SESSION then use it, otherwise use GET params
if (array_key_exists('lang', $_SESSION)) {
    $lang = strtolower($_SESSION['lang']);
    require __DIR__ . '/' . $lang . '.php';
    ## echo "You current language is <strong>$lang</strong>";
}
else {
	if (array_key_exists('lang', $_GET)) $lang = strtolower($_GET['lang']);

    ## if language is not set or is not available, then use default value
    if ( !isset($lang) || !in_array($lang, $known_languages )) {
        $lang = $_C['default_language'];
    }
	
    require __DIR__ . '/' . $lang . '.php';
    $SESSION["lang"] = $lang; 
}

$lang_icons = $known_languages;
if (in_array($lang, $lang_icons)) {
	unset($lang_icons[array_search($lang, $lang_icons)]);
}

?>