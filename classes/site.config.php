<?php

$_C = array(
    'db' => array(
      'host' => 'localhost',
      'port' => 3306,
      'username' => 'mercury',
      'password' => 'xsZ9d6GX',
      'name' => 'forcezine_mercury'
    ),
  'pages' => array(
    'login_page' => '/auth/login.php',
    'home_page' => '/'
  ),
  'log' => array( 'name' => 'log.log'),
  'domain' => 1
);

require_once __DIR__ . '/site.entities.php';

$_DB = new PDO('pgsql:dbname='. $_C['db']['name'] .' host='. $_C['db']['host'], $_C['db']['username'], $_C['db']['password']);

$_E = new \Classes\Entites($_DB, $_C['domain']);

?>