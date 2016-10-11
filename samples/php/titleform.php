<?php header("Content-Type: text/html; charset=iso-8559-1"); ?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
  "http://www.w3.org/TR/html4/loose.dtd">
<html><head>
<meta http-equiv="Content-Type"
      content="text/html; charset=iso-8859-1" />
<link href="form.css" rel="stylesheet" type="text/css">
<title>mylibrary title form</title>
</head><body>

<?php

require_once 'mydb.php';
require_once 'mylibraryfunctions.php';
require_once 'formfunctions.php';

// connect to MySQL
$db = new MyDb();

// data transfer:
//   - form data: form[] array
//   - url data:  editID=...

// show form?
$showform=TRUE;

// titleID to edit?
if(($editID = array_item($_REQUEST, 'editID')) && is_numeric($editID))
  $formdata = read_title_data($editID);
else {
  // process form data
  $formdata = array_item($_POST, "form");
  if(is_array($formdata)) {
    // get rid of magic quotes
    if(get_magic_quotes_gpc())
      while($i = each($formdata))
        $formdata[$i[0]] = stripslashes($i[1]);

    // what to do?
    if(array_item($formdata, "btnClear"))
      // clear form
      $formdata = FALSE;

    elseif(array_item($formdata, "btnDelete")) {
      // ask, if really delete
      if(build_delete_form($formdata))
        $showform=FALSE; }

    elseif(array_item($formdata, "btnReallyDelete")) {
      // delete title
      $db->execute("START TRANSACTION");
      if(delete_title($formdata))
        $db->execute("COMMIT");
      else
        $db->execute("ROLLBACK");
      $formdata = FALSE; }

    elseif(validate_data($formdata)) {
      // try to validate and save date
      $db->execute("START TRANSACTION");
      if(save_data($formdata))
        $db->execute("COMMIT");
      else
        $db->execute("ROLLBACK");
      $formdata = FALSE; }
  }
}

if($showform) {
  // input new or edit existing data?
  if(array_item($formdata, "titleID"))
    echo "<h1>Edit title</h1>";
  else
    echo "<h1>Input new title</h1>";

  // show form to input / edit data
  build_form($formdata);

  // link to search form
  echo "<p><br />",
    build_href("find.php", "", "Search for titles/authors"),
    "</p>\n";
}

// $db->showStatistics();

?>
</body></html>


<?php    // functions

// build form for title input/change
// the form is formated using a table with 4 columns
function build_form($formdata) {
  global $db;

  // start form
  form_start("titleform.php");

  // explain
  form_new_line();
  form_asis("You must specify at least the title and one author." .
    "<br />Authors: Last names first " .
    "(<i>King Stephen</i>, not <i>Stephen King</i>)!" .
    "<br />If a book has more authors, separate them " .
    "with semicolons (<i>author1;author2</i>)." .
    "<br />Publishers, languages: You can either choose an " .
    "existing item or input a new one.", 4);
  form_end_line();

  // title
  form_new_line();
  form_label("Title:", TRUE);
  form_text("title", array_item($formdata, "title"), 60, 100, 3);
  form_end_line();

  // subtitle
  form_new_line();
  form_label("Subtitle:");
  form_text("subtitle", array_item($formdata, "subtitle"), 60, 100, 3);
  form_end_line();

  // authors
  form_new_line();
  form_label("Authors:", TRUE);
  form_text("authors", array_item($formdata, "authors"), 60, 100, 3);
  form_end_line();

  // publishers
  form_new_line();
  form_label("Publisher:");
  $sql = "SELECT publName, publID FROM publishers ORDER BY publName";
  form_list("publisher", $db->queryArray($sql), array_item($formdata, "publisher"));
  form_label("New publisher:");
  form_text("newpubl", array_item($formdata, "newpubl"), 20, 40);
  form_end_line();

  // category
  form_new_line();
  form_label("Category:");
  // get all categories
  $sql = "SELECT catName, catID, parentCatID FROM categories ORDER BY catName";
  $rows = $db->queryObjectArray($sql);
  // build two arrays:
  //   subcats[catID] contains an array with all sub-catIDs
  //   catNames[catID] contains the catName for catID
  foreach($rows as $row) {
    $subcats[$row->parentCatID][] = $row->catID;
    $catNames[$row->catID] = $row->catName; }
  // build hierarchical list
  $rows = build_category_array($subcats[NULL], $subcats, $catNames);
  form_list("category", $rows , array_item($formdata, "category"));
  form_url("categories.php", "Edit categories", 2);
  form_end_line();

  // publishing year
  form_new_line();
  form_label("Publishing year:");
  form_text("publyear", array_item($formdata, "publyear"), 4, 4);
  form_label("Edition:");
  form_text("edition", array_item($formdata, "edition"), 4, 4);
  form_end_line();

  // language
  form_new_line();
  form_label("Language:");
  $sql = "SELECT langName, langID FROM languages ORDER BY langName";
  form_list("language", $db->queryArray($sql), array_item($formdata, "language"));
  form_label("New language:");
  form_text("newlang", array_item($formdata, "newlang"), 20, 40);
  form_end_line();

  // buttons
  form_new_line();
  form_label("");
  form_button("btnSave", "Save");
  // delete button for existing titles
  if(array_item($formdata, "titleID")) {
    form_button("btnDelete", "Delete title");
    form_hidden("titleID", $formdata["titleID"]); }
  else
    form_empty_cell(1);
  form_button("btnClear", "Input new title (clear form)");
  form_end_line();

  // end form
  form_end();
}

// build form to ask, if title should be deleted
function build_delete_form($formdata) {
  global $db;
  if($titleID = array_item($formdata, "titleID")) {
    $sql = "SELECT title FROM titles WHERE titleID=$titleID";
    if($rows = $db->queryObjectArray($sql)) {
      form_start("titleform.php");
      form_new_line();
      form_caption("Really delete title " . $rows[0]->title . "?", 2);
      form_end_line();

      form_new_line();
      form_button("btnReallyDelete", "YES, delete title");
      form_button("btnClear", "NO, cancel");
      form_end_line();
      form_hidden("titleID", $titleID);
      form_end();
      return TRUE;
    }
  }
  return FALSE;
}

// read all data for a certain title from database
// and save it in an array; return this array
function read_title_data($titleID) {
  global $db;
  $sql = "SELECT title, subtitle, titleID, langID, " .
         "       publID, catID, year, edition " .
         "FROM   titles WHERE titleID=$titleID";
  $rows = $db->queryObjectArray($sql);
  if(is_array($rows) && sizeof($rows)==1) {
    $row = $rows[0];
    $result["titleID"]   = $row->titleID;
    $result["title"]     = $row->title;
    $result["subtitle"]  = $row->subtitle;
    $result["publisher"] = $row->publID;
    $result["category"]  = $row->catID;
    $result["language"]  = $row->langID;
    $result["publyear"]  = $row->year;
    $result["edition"]  =  $row->edition;
    $result["authors"]   = "";
    $sql = "SELECT authName FROM authors, rel_title_author " .
           "WHERE authors.authID = rel_title_author.authID " .
           "AND rel_title_author.titleID = $titleID " .
           "ORDER BY authName";
    $rows = $db->queryObjectArray($sql);
    foreach($rows as $row)
      if(!$result["authors"])
        $result["authors"] = $row->authName;
      else
        $result["authors"] .= ";" . $row->authName;
    return $result;
  }
}

// tests if input data is valid; returns TRUE (valid) or FALSE
// prints error messages
function validate_data($formdata) {
  $result = TRUE;
  if(trim($formdata["title"])=="") {
    show_error_msg("You must specify a title!");
    $result = FALSE; }
  if(trim($formdata["authors"])=="") {
    show_error_msg("You must specify at least one title!");
    $result = FALSE; }
  $year = $formdata["publyear"];
  if(!empty($year) && ((!is_numeric($year)) || $year<1000 || $year>2100)) {
    show_error_msg("Publishing year must be a four-digit number (or empty).");
    $result = FALSE; }
  if(!empty($edition) && ((!is_numeric($edition)) || $edition<1 || $edition>100)) {
    show_error_msg("Edition must be a number <= 100 (or empty).");
    $result = FALSE; }
  return $result;
}

// save input data
function save_data($formdata) {
  global $db;

  // save new authors / get authIDs
  $authors = explode(";", $formdata["authors"]);
  foreach($authors as $author) {
    $author=trim($author);
    $sql = "SELECT authID FROM authors WHERE authName = " .
      $db->sql_string($author);
    $rows = $db->queryObjectArray($sql);
    if($rows)
      // existing author
      $authIDs[] = $rows[0]->authID;
    else {
      // new author
      $sql = "INSERT INTO authors (authName) " .
        "VALUES (" . $db->sql_string($author) . ")";
      if(!$db->execute($sql))
        return FALSE;
      $authIDs[] = $db->insertId();
    }
  }

  // save publisher / get publID
  if($formdata["newpubl"]) {
    $sql = "SELECT publID FROM publishers WHERE publName = " .
      $db->sql_string($formdata["newpubl"]);
    $rows = $db->queryObjectArray($sql);
    if($rows)
      // existing publisher
      $publID = $rows[0]->publID;
    else {
      // new publisher
      $sql = "INSERT INTO publishers (publName) " .
        "VALUES (" . $db->sql_string($formdata["newpubl"]) . ")";
      if(!$db->execute($sql))
        return FALSE;
      $publID = $db->insertId();
    }
  }
  else
    // take publID from selection list
    $publID = $formdata["publisher"];

  // save language / get langID
  if($formdata["newlang"]) {
    $sql = "SELECT langID FROM languages WHERE langName = " .
      $db->sql_string($formdata["newlang"]);
    $rows = $db->queryObjectArray($sql);
    if($rows)
      // existing publisher
      $langID = $rows[0]->langID;
    else {
      // new publisher
      $sql = "INSERT INTO languages (langName) " .
        "VALUES (" . $db->sql_string($formdata["newlang"]) . ")";
      if(!$db->execute($sql))
        return FALSE;
      $langID = $db->insertId();
    }
  }
  else
    // take langID from selection list
    $langID = $formdata["language"];

  // update existing title
  if(array_item($formdata, "titleID")) {
    $titleID = array_item($formdata, "titleID");
    $sql = "UPDATE titles SET " .
      "title="    . $db->sql_string($formdata["title"]) . ", " .
      "subtitle=" . $db->sql_string($formdata["subtitle"]) . ", " .
      "langID="   . ID_or_NULL($langID) . "," .
      "publID="   . ID_or_NULL($publID) . "," .
      "catID="    . ID_or_NULL($formdata["category"]) . "," .
      "year="     . num_or_NULL($formdata["publyear"]) . ", " .
      "edition="  . num_or_NULL($formdata["edition"]) . " " .
      "WHERE titleID=$titleID";
    if(!$db->execute($sql))
      return FALSE;
    // remove existing title-author connections
    $sql = "DELETE FROM rel_title_author WHERE titleID=$titleID";
    if(!$db->execute($sql))
      return FALSE;
  }
  else {
    // insert new title
    $sql = "INSERT INTO titles (title, subtitle, " .
      "langID, publID, catID, year, edition) VALUES (" .
      $db->sql_string($formdata["title"]) . ", " .
      $db->sql_string($formdata["subtitle"]) . ", " .
      ID_or_NULL($langID) . "," .
      ID_or_NULL($publID) . "," .
      ID_or_NULL($formdata["category"]) . "," .
      num_or_NULL($formdata["publyear"]). "," .
      num_or_NULL($formdata["edition"]) . ") ";
    if(!$db->execute($sql))
      return FALSE;
    $titleID = $db->insertId();
  }

  // connect author and titles
  foreach($authIDs as $authID) {
    $sql = "INSERT INTO rel_title_author (titleID, authID) " .
      "VALUES ($titleID, $authID)";
    if(!$db->execute($sql))
      return FALSE;
  }

  // message
  echo "<p>Title ",
    build_href("titleform.php", "editID=$titleID", $formdata['title']),
    " has been saved.</p>\n";
  return TRUE;
}

// delete one title
function delete_title($formdata) {
  global $db;
  if((!$titleID = array_item($formdata, "titleID")) || !is_numeric($titleID))
    return FALSE;
  $sql = "DELETE FROM rel_title_author WHERE titleID=$titleID";
  if(!$db->execute($sql))
    return FALSE;
  $sql = "DELETE FROM titles WHERE titleID=$titleID LIMIT 1";
  if(!$db->execute($sql))
    return FALSE;
  echo "<p>One title has been deleted.</p>\n";
  return TRUE;
}

function ID_or_NULL($id) {
  if($id=="none")
    return 'NULL';
  else
    return $id;
}

function num_or_NULL($n) {
  if(is_numeric($n))
    return $n;
  else
    return 'NULL';
}

?>