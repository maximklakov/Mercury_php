<?php
require __DIR__ . "/../class.logsys.php";
\Fr\LS::config(array(
    "db" => array(
      "host" => "localhost",
      "port" => 3306,
      "username" => "mercury",
      "password" => "mercury",
      "name" => "mercury",
      "table" => "main.logins",
      "token_table" => "main.reset_tokens"
    ),
  "features" => array(
    "auto_init" => true
  ),
  "pages" => array(
    "no_login" => array(
      "/auth/",
      "/auth/reset.php",
      "/auth/register.php"
    ),
    "login_page" => "/auth/login.php",
    "home_page" => "/"
  )
));
