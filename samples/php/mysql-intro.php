<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
  "http://www.w3.org/TR/html4/loose.dtd">
<html><head>
<meta http-equiv="Content-Type"
      content="text/html; charset=iso-8859-1" />
<title>PHP Programming, mysqli sample</title>
</head><body>

<?php

$mysqlhost = "localhost";    // name of computer MySQL is running
$mysqluser = "root";         // username
$mysqlpasswd = "uranus";     // password
$mysqldb   = "mylibrary";

if($conn = @mysql_connect($mysqlhost, $mysqluser, $mysqlpasswd)) {
  mysql_select_db($mysqldb);
  if($result=mysql_query("SELECT * FROM titles ORDER BY title")) {
    printf("<p>Number of records: %d</p>\n", mysql_num_rows($result));
    printf("<p>Number of columns: %d</p>\n", mysql_num_fields($result));
    while($row = mysql_fetch_object($result)) {
      if($row->subtitle)
        printf("<br />%s -- %s\n", htmlspecialchars($row->title),
          htmlspecialchars($row->subtitle));
      else
        printf("<br />%s\n", htmlspecialchars($row->title));
    }
    mysql_free_result($result);
  }
} else {
  printf("<p>Sorry, could not connect to MySQL server! %s</p>\n",
    mysql_error());
}
mysql_close($conn);

?>
</body></html>
