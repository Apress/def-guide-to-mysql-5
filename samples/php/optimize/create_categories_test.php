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

if($categories_exists && !$backup_exists) {
  // rename categories table if no backup exists
  $sql = "ALTER TABLE titles DROP FOREIGN KEY titles_ibfk_3";
  $db->execute($sql);
  $sql = "RENAME TABLE categories TO oldcategories";
  $db->execute($sql);

} elseif($categories_exists && $backup_exists) {
  // drop categories table, if backup is already here
  $sql = "DROP TABLE categories";
  $db->execute($sql);
}

// create new categories table
$sql = "CREATE TABLE categories ( " .
       "  catID       int NOT NULL auto_increment, " .
       "  catName     varchar(60) collate latin1_german1_ci NOT NULL default '', " .
       "  parentCatID int default NULL, " .
       "  indent      int, " .
       "  PRIMARY KEY  (catID), "  .
       "  KEY catName (catName), " .
       "  KEY parentCatID (parentCatID), " .
       "  CONSTRAINT categories_ibfk_1 FOREIGN KEY (parentCatID) " .
       "    REFERENCES categories (catID) )" .
       "ENGINE=InnoDB " .
       "DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci";
$db->execute($sql);

// fill categories with random data
// array for each level of categories
// each item: no. of insert operations
//            no. of items per insert
$no_of_items = array(array( 1, 30),  // create 30 level-1 categories
                     array(20, 10),  // create 20*10 level-2 categories
                     array(40,  6),  // ...
                     array(50,  5),
                     array(40,  4),
                     array(40,  3),
                     array(40,  3));

// insert first entry (level 0)
$sql = "INSERT INTO categories (catName, parentCatID, indent) " .
       "VALUES ('all books', NULL, 0)";
$db->execute($sql);

// loop from level 1 to 7
for($level=1; $level<=sizeof($no_of_items); $level++) {
  $iterations = $no_of_items[$level-1][0];
  $items      = $no_of_items[$level-1][1];

  // get all parent categories
  $sql = "SELECT catID FROM categories WHERE indent=" . ($level-1) ;
  $parentcats = $db->queryArray($sql);
  $no_parents = sizeof($parentcats);

  // loop for insert operations
  for($n=0; $n<$iterations; $n++) {

    // choose a parent category to insert new categories
    $catID = $parentcats[rand(0, $no_parents-1)][0];

    // build string to insert $realitems new categories
    $realitems = $items * 0.666 + rand(0, $items * 0.666);
    $newcats = "";
    for($i=0; $i<$realitems; $i++) {
      $newcats .= random_string(10 + rand(0, 19)) . ";";
    }

    // insert new categories
    insert_new_categories($catID, $newcats, $level);
  }
}

// drop indent column (only needed for insert operation)
$sql = "ALTER TABLE categories DROP indent";
$db->execute($sql);

// get no of categories
$sql = "SELECT COUNT(*) FROM categories";
$n = $db->querySingleItem($sql);
echo "<p>New table categories has $n items</p>\n";

echo '<p>Links:';
echo '<br /><a href="show_categories_list.php">show_categories_list.php</a>';
echo '<br /><a href="remove_categories_test.php">remove_categories_test.php</a>';
echo "</p>\n";

// insert new subcategories to given category
function insert_new_categories($insertID, $subcategories, $indent) {
  global $db;
  $subcatarray = explode(";", $subcategories);
  $count = 0;
  foreach($subcatarray as $newcatname) {
    $result = insert_new_category($insertID, trim($newcatname), $indent);
    if($result == -1) {
      echo "<p>Sorry, an error happened. Nothing was saved.</p>\n";
      return FALSE; }
    elseif($result)
      $count++;
  }
  return TRUE;
}

// insert a new category into the categories table
// returns -1, if error
//         1,  if category could be saved
//         0,  if category could not be saved
function insert_new_category($insertID, $newcatName, $indent) {
  global $db;
  // test if newcatName is empty
  if(!$newcatName) return 0;
  $newcatName = $db->sql_string($newcatName);

  // insert new category
  $sql = "INSERT INTO categories (catName, parentCatID, indent) " .
         "VALUES ($newcatName, $insertID, $indent)";
  if($db->execute($sql))
    return 1;
  else
    return -1;
}

// returns random string with $n characters
function random_string($n) {
  $tmp = "";
  for($i=0; $i<$n; $i++)
    $tmp .= chr(rand(97, 97+24));
  return $tmp;
}


?>