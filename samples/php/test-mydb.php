<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
  "http://www.w3.org/TR/html4/loose.dtd">
<html><head>
<meta http-equiv="Content-Type"
      content="text/html; charset=iso-8859-1" />
<title>PHP Programming, mysqli sample</title>
</head><body>

<?php

require_once("mydb.php");

// connect
$db = new MyDb();

// query for a single item (number)
if(($n = $db->querySingleItem("SELECT COUNT(*) FROM titles"))!=-1)
  printf("<p>No. of records in titles: %d</p>\n", $n);

// INSERT record
$db->execute("INSERT INTO titles (title, subtitle) VALUES ('test', 'subtest')");
$id=$db->insertId();
printf("<p>insertid=%d</p>\n", $id);

// SELECT records
if($result = $db->queryObjectArray("SELECT * FROM titles")) {
  foreach($result as $row)
    printf("<br />TitleID=%d Title=%s Subtitle=%s\n",
      $row->titleID, $row->title, $row->subtitle);
}

// DELETE record
$db->execute("DELETE FROM titles WHERE titleID=" . $id);

// close connection
$db->close();

?>
</body></html>
