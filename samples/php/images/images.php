<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
  "http://www.w3.org/TR/html4/loose.dtd">
<html><head>
<meta http-equiv="Content-Type"
      content="text/html; charset=iso-8859-1" />
<link href="table.css" rel="stylesheet" type="text/css">
<title>Handling images</title>
</head><body>

<?php   // images/images.php

include("connect.php");
$mysqli = connect_to_picdb();

// part 1: save uploaded images
$submitbtn = array_item($_POST,  'submitbtn');
$descr =     array_item($_POST,  'descr');
$imgfile =   array_item($_FILES, 'imgfile');

// is there form data to process?
if($submitbtn == 'OK' and is_array($imgfile)) {
  $name    = $imgfile['name'];
  $type    = $imgfile['type'];
  $size    = $imgfile['size'];
  $uperr   = array_item($imgfile, 'error');
  $tmpfile = $imgfile['tmp_name'];
  if(!$descr) $descr = $name;
  switch ($type) {
  case "image/gif":
    $mime = "GIF Image";  break;
  case "image/jpeg":
  case "image/pjpeg":
    $mime = "JPEG Image"; break;
  case "image/png":
  case "image/x-png":
    $mime = "PNG Image";  break;
  default:
    $mime = "unknown";
  }
  if(!$tmpfile or $uperr or $mime == "unknown" or !is_uploaded_file($tmpfile))
    echo "<p>An error occured when processing the form data:
             Perhaps you forgot to specify an
             image file or the file is too large
             or the image type is unknown.</p>\n"; 
  else {
    // read the uploaded file and save it into database
    $file = fopen($tmpfile, "rb");
    $imgdata = fread($file, $size);
    fclose($file);
    if(!$mysqli->query(
        "INSERT INTO images (name, type, image) " .
        "VALUES ('" . $mysqli->escape_string($descr) . "', " .
        "        '$mime', " .
        "        '" . $mysqli->escape_string($imgdata) . "')"))
      printf("<p>Could not save image: %s</p>\n", $mysqli->error);
  }
}

// part 2: show images
echo "<h2>Images recently uploaded ...</h2>\n";
$sql =
  "SELECT id, name, " .
  "DATE_FORMAT(ts, '%Y/%c/%e %k:%i') AS dt " .
  "FROM images ORDER BY ts DESC LIMIT 10";
$result = $mysqli->query($sql);
if($result->num_rows==0)
  echo "<p>The database does not yet contain images ...</p>\n";
else {
  while($row = $result->fetch_object())
    $rows[] = $row;
  echo '<table>', "\n<tr>";
  for($i=0; $i<sizeof($rows); $i++)  // images
    echo '<th>',
      "<img src=\"showpic.php?id=" .
      $rows[$i]->id . "\" /></th>";
  echo "</tr>\n<tr>";
  for($i=0; $i<sizeof($rows); $i++)  // names/descriptions
    echo "<td>" . htmlspecialchars($rows[$i]->name) . "</td>";
  echo "</tr>\n<tr>";
  for($i=0; $i<sizeof($rows); $i++)  // date+time
    echo "<td>" . $rows[$i]->dt . "</td>";
  echo "</tr>\n</table>\n";
}

// part 3: upload form
?>

<h2>Image upload</h2>

<p>Maximum file size 200 kB. Formats: PNG, JPEG and GIF.</p>

<table>
<form method="post" action="images.php" enctype="multipart/form-data">
  <input type="hidden" value="204800" name="MAX_FILE_SIZE" />
  <tr><td>Description (optional):</td>
       <td><input name="descr" type="text" /></td></tr>
  <tr><td>Image file:</td>
       <td><input name="imgfile" type="file" /></td></tr>
  <tr><td></td>
       <td><input type="submit" value="OK" name="submitbtn" /></td></tr>
</form>
</table>

</body></html>
