<?php header("Content-Type: text/html; charset=iso-8559-1"); ?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
  "http://www.w3.org/TR/html4/loose.dtd">
<html><head>
<meta http-equiv="Content-Type"
      content="text/html; charset=iso-8859-1" />
<title>mylibrary categories</title>
</head><body>

<?php

require_once 'mydb.php';
require_once 'mylibraryfunctions.php';

// connect to MySQL
$db = new MyDb();

// read form and URL variables
$insertID      = array_item($_REQUEST, 'insertID');
$deleteID      = array_item($_REQUEST, 'deleteID');
$submitbutton  = array_item($_POST, 'submitbutton');
$subcategories = array_item($_POST, 'subcategories');

// remove magic quotes
if(get_magic_quotes_gpc())
  $subcategories = stripslashes($subcategories);

// test if variable deleteID was set to a valid value;
// if so, delete category and all subcategories
if($deleteID) {
  $sql = "SELECT COUNT(*) FROM categories WHERE catID='$deleteID'";
  if($db->querySingleItem($sql)==1) {
    $db->execute("START TRANSACTION");
    if(delete_category($deleteID)==-1)
      $db->execute("ROLLBACK");
    else
      $db->execute("COMMIT");
  }
}

// test if variable insertID was set to a valid value
if($insertID) {
  $sql = "SELECT COUNT(*) FROM categories WHERE catID='$insertID'";
  $n = $db->querySingleItem($sql); }

// if url had valid insertID, show this category and
// an input form for new subcategories
if($insertID && $n==1) {
  echo "<h2>Insert new categories</h2>\n";

  // if there is form data to process, insert new
  // subcategories into database
  if($subcategories) {
    $db->execute("START TRANSACTION");
    if(insert_new_categories($insertID, $subcategories))
      $db->execute("COMMIT");
    else
      $db->execute("ROLLBACK"); }

  print_category_entry_form($insertID);
}

// otherwise show hierarchical list of all categories
else {
  echo "<h2>Choose category</h2>\n";
  echo "<p>Click to insert/delete categories.</p>\n";

  // query for all categories
  $sql = "SELECT catName, catID, parentCatID FROM categories ORDER BY catName";
  $rows = $db->queryObjectArray($sql);
  // build two arrays:
  //   subcats[catID] contains an array with all sub-catIDs
  //   catNames[catID] contains the catName for catID
  foreach($rows as $row) {
    $subcats[$row->parentCatID][] = $row->catID;
    $catNames[$row->catID] = $row->catName; }
  // build hierarchical list
  print_categories($subcats[NULL], $subcats, $catNames);

  // link to input and search forms
  printf("<p><br />%s<br />%s</p>\n",
    build_href("titleform.php", "", "Input new title"),
    build_href("find.php", "", "Search for titles/authors"));
}

// $db->showStatistics();

?>
</body></html>


<?php    // functions


// searches for $rows[n]->parentCatID=$parentCatID
// and prints $rows[n]->catName; then calls itself
// recursively
function print_categories($catIDs, $subcats, $catNames) {
  echo "<ul>";
  foreach($catIDs as $catID) {
    printf("<li>%s (%s, %s, %s)</li>\n",
      htmlspecialchars($catNames[$catID]),
      build_href("categories.php", "insertID=$catID", "insert"),
      build_href("categories.php", "deleteID=$catID", "delete"),
      build_href("find.php", "catID=$catID", "show titles"));
    if(array_key_exists($catID, $subcats))
      print_categories($subcats[$catID], $subcats, $catNames);
  }
  echo "</ul>\n";
}

// show current category, all higher level categories,
// all subcategories (one level only) and a form
// to enter new subcategories
function print_category_entry_form($insertID) {
  global $db;

  // query for all categories
  $sql  = "SELECT catName, catID, parentCatID " .
          "FROM categories ORDER BY catName";
  $rows = $db->queryObjectArray($sql);

  // build assoc. arrays for name, parent and subcats
  foreach($rows as $row) {
    $catNames[$row->catID] = $row->catName;
    $parents[$row->catID] = $row->parentCatID;
    $subcats[$row->parentCatID][] = $row->catID;   }

  // build list of all parents for $insertID
  $catID = $insertID;
  while($parents[$catID]!=NULL) {
    $catID = $parents[$catID];
    $parentList[] = $catID;   }

  // display all parent categories (root category first)
  if(isset($parentList))
    for($i=sizeof($parentList)-1; $i>=0; $i--)
      printf("<ul><li>%s</li>\n", htmlspecialchars($catNames[$parentList[$i]]));

  // display choosen category bold
  printf("<ul><li><b>%s</b></li>\n", htmlspecialchars($catNames[$insertID]));

  // display existing subcategories (only one level) for choosen category
  // with delete link; we still use the results of the last SELECT query
  echo "<ul>";
  $subcat=0;
  if(array_key_exists($insertID, $subcats))
    foreach($subcats[$insertID] as $catID)
      printf("<li>%s (%s)</li>\n",
        htmlspecialchars($catNames[$catID]),
        build_href("categories.php",
          "insertID=$insertID&deleteID=$catID", "delete"));
  else
    echo "(No subcategories yet.)";
  echo "</ul>\n";

  // close hierarchical category list
  if(isset($parentList))
    echo str_repeat("</ul>", sizeof($parentList)+1), "\n";

  echo '<form method="post" action="categories.php?insertID=',
    $insertID, '">', "\n",
    "<p>Insert new subcategories to ",
    "<b>$catNames[$insertID]</b>. <br />You may add several ",
    "subcategories at once. <br />Use ; to seperate ",
    "your entries.</p>\n".
    '<p><input name="subcategories" size="60" maxlength="80" />', "\n",
    '<input type="submit" value="OK" name="submitbutton" /></p>', "\n",
    "</form>\n";

  // link back to categories
  echo "<p>Back to full ",
    build_href("categories.php", "", "categories list") . ".\n";
}

// insert new subcategories to given category
function insert_new_categories($insertID, $subcategories) {
  global $db;
  $subcatarray = explode(";", $subcategories);
  $count = 0;
  foreach($subcatarray as $newcatname) {
    $result = insert_new_category($insertID, trim($newcatname));
    if($result == -1) {
      echo "<p>Sorry, an error happened. Nothing was saved.</p>\n";
      return FALSE; }
    elseif($result)
      $count++;
  }
  if($count)
    if($count==1)
      echo "<p>One new category has been inserted.</p>\n";
    else
      echo "<p>$count new categories have been inserted.</p>\n";
  return TRUE;
}

// insert a new category into the categories table
// returns -1, if error
//         1,  if category could be saved
//         0,  if category could not be saved
function insert_new_category($insertID, $newcatName) {
  global $db;
  // test if newcatName is empty
  if(!$newcatName) return 0;
  $newcatName = $db->sql_string($newcatName);

  // test if newcatName already exists
  $sql = "SELECT COUNT(*) FROM categories " .
         "WHERE parentCatID=$insertID " .
         "  AND catName=$newcatName";
  if($db->querySingleItem($sql)>0) {
    return 0; }

  // insert new category
  $sql = "INSERT INTO categories (catName, parentCatID) " .
         "VALUES ($newcatName, $insertID)";
  if($db->execute($sql))
    return 1;
  else
    return -1;
}

// delete a category
// return  1, if category and its subcategories could be deleted
// returns 0, if the category could not be deleted
// return -1 if an error happens
function delete_category($catID) {
  // find subcategories to catID and delete them
  // by calling delete_category recursively
  global $db;
  $sql = "SELECT catID FROM categories " .
         "WHERE parentCatID='$catID'";
  if($rows = $db->queryObjectArray($sql)) {
    $deletedRows = 0;
    foreach($rows as $row) {
      $result = delete_category($row->catID);
      if($result==-1)
        return -1;
      else
        $deletedRows++;
    }
    // if any subcategories could not be deleted,
    // don't delete this category as well
    if($deletedRows != count($rows))
      return 0;
  }

  // delete catID
  // don't delete catIDs<=11
  if($catID<=11) {
    echo "<br />You cannot delete categories with catID<=11 in this sample.\n";
    return 0;
  }

  // if category is in use, don't delete it!
  $sql = "SELECT COUNT(*) FROM titles WHERE catID='$catID'";
  if($n = $db->querySingleItem($sql)>0) {
    $sql = "SELECT catName FROM categories WHERE catID='$catID'";
    $catname = $db->querySingleItem($sql);
    printf("<br />Category %s is used in %d titles. " .
           "You cannot delete it.\n", $catname, $n);
    return 0;
  }

  // delete category
  $sql = "DELETE FROM categories WHERE catID='$catID' LIMIT 1";
  if($db->execute($sql))
    return 1;
  else
    return -1;
}

?>
