<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
  "http://www.w3.org/TR/html4/loose.dtd">
<html><head>
<meta http-equiv="Content-Type"
      content="text/html; charset=iso-8859-1" />
<title>PHP Programming, mysqli sample</title>
</head><body>

<?php

// SQL-Kommandos mit Parametern

// Verbindung herstellen
require_once 'password.php';
$mysqli = new mysqli($mysqlhost, $mysqluser, $mysqlpasswd, $mysqldb);

// testen, ob Verbindung OK
if(mysqli_connect_errno()) {
  echo "<p>Sorry, no connection! ", mysqli_connect_error(), "</p>\n";
  exit();
}

// SQL-Kommando mit Parametern vorbereiten
$stmt = $mysqli->prepare(
  "INSERT INTO titles (title, subtitle, langID) VALUES (?, ?, ?)");
$stmt->bind_param('ssi', $title, $subtitle, $langID);

// Kommando mehrfach ausführen
$title="new Linux title 1";
$subtitle="new subtitle 1";
$langID=1;
$stmt->execute();

$title="new MySQL title 2";
$subtitle="new subtitle 2";
$langID=2;
$stmt->execute();

// Kommando freigeben
$stmt->close();

// Kombination von bind_param und bind_result
$stmt = $mysqli->prepare(
  "SELECT titleID, title FROM titles WHERE title LIKE ?");
$stmt->bind_param('s', $pattern);

$pattern="%Linux%";
$stmt->execute();
$stmt->store_result();
$stmt->bind_result($titleID, $title);
echo "<p></p>\n";
while($stmt->fetch())
  printf("<br />%d %s\n", $titleID, htmlspecialchars($title));

$pattern="%MySQL%";
$stmt->execute();
$stmt->store_result();
$stmt->bind_result($titleID, $title);
echo "<p></p>\n";
while($stmt->fetch())
  printf("<br />%d %s\n", $titleID, htmlspecialchars($title));
$stmt->close();

// neue Datensätze löschen
$mysqli->query("DELETE FROM titles WHERE title LIKE 'new %'");

// Verbindung beenden
$mysqli->close();

?>
</body></html>
