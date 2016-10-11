<?php

require_once 'spfunctions.php';
require_once 'password.php';

$dbname = array_item($_REQUEST, 'dbname');
if(!$dbname)
  exit;
else
  $dbname = urldecode($dbname);

$mysqli = @new mysqli($mysqlhost, $mysqluser, $mysqlpasswd);
if(mysqli_connect_errno()) {
  html_start('MySQL connection error');
  printerror("Sorry, no connection! (" . mysqli_connect_error() . ")");
  html_end();
  exit(); }

header('Content-Type: text/plain');  // application/octet-stream
header('Expires: ' . gmdate('D, d M Y H:i:s') . ' GMT');
header('Content-Disposition: attachment; filename="sp.sql"');
echo backup_sps($mysqli, $dbname);
exit;

?>