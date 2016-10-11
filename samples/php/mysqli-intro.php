<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
  "http://www.w3.org/TR/html4/loose.dtd">
<html><head>
<meta http-equiv="Content-Type"
      content="text/html; charset=iso-8859-1" />
<title>PHP Programming, mysqli sample</title>
</head><body>

<?php

// Verbindung herstellen
$mysqlhost   = "localhost";  // name of computer MySQL is running
$mysqluser   = "root";            // username
$mysqlpasswd = "uranus";          // password
$mysqldb     = "mylibrary";
$mysqli      = new mysqli($mysqlhost, $mysqluser, $mysqlpasswd, $mysqldb);

// testen, ob Verbindung OK
if(mysqli_connect_errno()) {
  echo "<p>Sorry, no connection! ", mysqli_connect_error(), "</p>\n";
  exit();
}

// Schleife durch alle Ergebnisse
if($result = $mysqli->query("SELECT * FROM titles")) {
  printf("<p>Gefundene Datensätze: %d</p>\n", $result->num_rows);
  printf("<p>Anzahl der Spalten: %d</p>\n", $result->field_count);

//   echo "<p>Meta-Informationen: ";
//   foreach($result->fetch_fields() as $meta)
//     printf("<br />Name=%s Table=%s Len=%d Decimals=%s Type=%s\n",
//       $meta->name, $meta->table, $meta->max_length, $meta->decimals, $meta->type);

  while($row = $result->fetch_assoc()){
    if($row["subtitle"]==NULL)
      printf("<br />%s\n", htmlspecialchars($row["title"]));
    else
      printf("<br />%s -- %s\n", htmlspecialchars($row["title"]),
        htmlspecialchars($row["subtitle"]));
  }

  // Inhalt von result freigeben
  $result->close();
}

// Verbindung beenden
$mysqli->close();

?>
</body></html>
