<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
  "http://www.w3.org/TR/html4/loose.dtd">
<html><head>
<meta http-equiv="Content-Type"
      content="text/html; charset=iso-8859-1" />
<link href="form.css" rel="stylesheet" type="text/css">
<link href="resulttable.css" rel="stylesheet" type="text/css">
<title>speed optimization</title>
</head><body>

<?php

require_once '../mydb.php';
// require_once '../mylibraryfunctions.php';
require_once '../formfunctions.php';

// connect to MySQL
$db = new MyDb();

// get no of categories
$sql = "SELECT COUNT(*) FROM categories";
$n = $db->querySingleItem($sql);
echo "<p>Table categories has $n items</p>\n";

// variant 1: original code as in mylibraryfunctions.php
echo "<hr /><p></p>\n";
$db->resetStatistics();
$sql = "SELECT catName, catID, parentCatID FROM categories ORDER BY catName";
$categories = $db->queryObjectArray($sql);
$rows = build_category_array1($categories);
$db->showStatistics();

form_start("find.php");
form_new_line();
form_label("Test 1");
form_list("category", $rows , FALSE);
form_end_line();
form_end();

// variant 2: small queries
echo "<hr /><p></p>\n";
$db->resetStatistics();
$rows = build_category_array2();
$db->showStatistics();

form_start("find.php");
form_new_line();
form_label("Test 2");
form_list("category", $rows , FALSE);
form_end_line();
form_end();

// variant 3: big query, better PHP code
echo "<hr /><p></p>\n";
$db->resetStatistics();
// query for all categories
$sql  = "SELECT catName, catID, parentCatID FROM categories ORDER BY catName";
$rows = $db->queryObjectArray($sql);
// build two arrays:
//   subcats[catID] contains an array with all sub-catIDs
//   catNames[catID] contains the catName for catID
foreach($rows as $row) {
  $subcats[$row->parentCatID][] = $row->catID;
  $catNames[$row->catID] = $row->catName; }
$rows = build_category_array3($subcats[NULL], $subcats, $catNames);
$db->showStatistics();

form_start("find.php");
form_new_line();
form_label("Test 3");
form_list("category", $rows , FALSE);
form_end_line();
form_end();

echo '<p>Links:';
echo '<br /><a href="remove_categories_test.php">remove_categories_test.php</a>';
echo "</p>\n";

?>
</body></html>

<?php

// variant 1
function build_category_array1($rows, $parentCatID=NULL, $indent=0) {
  static $tmp;
  if($indent==NULL)
    $tmp=FALSE;  // unset does not work for static variables!
  foreach($rows as $row)
    if($row->parentCatID==$parentCatID) {
      $pair[0] = str_repeat(" ", $indent*3) . $row->catName;
      $pair[1] = $row->catID;
      $tmp[] = $pair;
      build_category_array1($rows, $row->catID, $indent+1);
    }
  if($indent==NULL)
    return $tmp;
}

// variant 2
function build_category_array2($parentCatID=NULL, $indent=0) {
  global $db;
  static $tmp;
  if($parentCatID==NULL) {
    $tmp = FALSE;  // unset does not work for static variables!
    $sql = "SELECT catName, catID FROM categories " .
           "WHERE ISNULL(parentCatID) ORDER BY catName"; }
  else
    $sql = "SELECT catName, catID FROM categories " .
           "WHERE parentCatID=$parentCatID ORDER BY catName";
  if($rows = $db->queryObjectArray($sql))
    foreach($rows as $row) {
      $pair[0] = str_repeat(" ", $indent*3) . $row->catName;
      $pair[1] = $row->catID;
      $tmp[] = $pair;
      build_category_array2($row->catID, $indent+1);
    }
  if($parentCatID==NULL)
    return $tmp;
}


// variant 3
function build_category_array3($catIDs, $subcats, $catNames, $indent=0) {
  static $tmp;
  if($indent==0)
    $tmp = FALSE;  // unset does not work for static variables!
  foreach($catIDs as $catID) {
    $pair[0] = str_repeat(" ", $indent*3) . $catNames[$catID];
    $pair[1] = $catID;
    $tmp[] = $pair;
    if(array_key_exists($catID, $subcats))
      build_category_array3($subcats[$catID], $subcats, $catNames, $indent+1);
  }
  if($indent==0)
    return $tmp;
}

?>