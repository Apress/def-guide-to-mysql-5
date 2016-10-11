<?php {  // images/showpic.php?id=n
  include("connect.php");

  // get id; exit if no id
  $id = array_item($_GET, 'id');
  if(!$id) exit;

  // connect to MySQL, query for picture
  $mysqli = connect_to_picdb();
  $result = $mysqli->query(
    "SELECT image, type FROM images WHERE id = $id");
  if(!$result) exit;

  // show picture
  $row = $result->fetch_object();
  if(!$row) exit;
  header($row->type);
  echo $row->image;
} ?>

