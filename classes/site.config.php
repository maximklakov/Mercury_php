<?php

$_C = array(
    'db' => array(
      'host' => 'localhost',
      'port' => 3306,
      'username' => 'mercury', // amuletgrey_estate
      'password' => 'xsZ9d6GX', // hFPaqa2U
      'name' => 'forcezine_mercury'
    ),
  'pages' => array(
    'login_page' => '/auth/login.php',
    'home_page' => '/'
  )
  ,'log' => array( 'name' => 'log.log')
  ,'domain' => 1
  ,'default_language' => 'ua'
);

require_once __DIR__ . '/site.entities.php';

$_DB = new PDO('pgsql:dbname='. $_C['db']['name'] .' host='. $_C['db']['host'], $_C['db']['username'], $_C['db']['password']);

$_E = new \Classes\Entites($_DB, $_C['domain']);

?>