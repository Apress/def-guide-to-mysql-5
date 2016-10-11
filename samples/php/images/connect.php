<?php
// images/connect.php

// connect to MySQL, activate database 'testimages';
function connect_to_picdb() {
  $mysqluser = "root";       // username
  $mysqlpw   = "uranus";     // password
  $mysqlhost = "localhost";  // name of computer MySQL is running
  $mysqldb   = "testimages"; // name of database

  $mysqli = new mysqli($mysqlhost, $mysqluser, $mysqlpw, $mysqldb);
  if(mysqli_connect_errno()) {
    echo "<p>Sorry, no connection to database ...</p></body></html>\n";
    exit();  }

  return $mysqli;
}

// test if an array contains a certain entry
// and return its content
function array_item($ar, $key) {
  if(is_array($ar) && array_key_exists($key, $ar))
    return($ar[$key]); }

?>
