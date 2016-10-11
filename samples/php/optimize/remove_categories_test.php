<?php

require_once '../mydb.php';
$db = new MyDb();
$backup_exists=FALSE;
$categories_exists=FALSE;

$sql = "SHOW TABLES like 'oldcategories'";
$rows = $db->queryArray($sql);
if($rows && sizeof($rows)==1)
  $backup_exists=TRUE;
$sql = "SHOW TABLES like 'categories'";
$rows = $db->queryArray($sql);
if($rows && sizeof($rows)==1)
  $categories_exists=TRUE;

if($categories_exists && $backup_exists) {
  // drop categories table, if backup is already here
  $sql = "DROP TABLE categories";
  $db->execute($sql);
}

if($backup_exists) {
  $sql = "RENAME TABLE oldcategories TO categories";
  $db->execute($sql);
  $sql = "ALTER TABLE titles ADD FOREIGN KEY titles_ibfk_3 (catID) REFERENCES categories (catID)";
  $db->execute($sql);
}

echo '<p>Links:';
echo '<br /><a href="create_categories_test.php">create_categories_test.php</a>';
echo '<br /><a href="show_categories_list.php">show_categories_list.php</a>';
echo "</p>\n";

?>