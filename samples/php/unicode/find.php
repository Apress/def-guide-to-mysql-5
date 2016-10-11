<?php header("Content-Type: text/html; charset=utf-8"); ?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
  "http://www.w3.org/TR/html4/loose.dtd">
<html><head>
<meta http-equiv="Content-Type"
      content="text/html; charset=utf-8" />
<link href="form.css" rel="stylesheet" type="text/css">
<link href="resulttable.css" rel="stylesheet" type="text/css">
<title>mylibrary search</title>
</head><body>

<?php

require_once 'mydb.php';
require_once 'mylibraryfunctions.php';
require_once 'formfunctions.php';

// connect to MySQL
$db = new MyDb();
$db->execute("SET NAMES 'utf8'");

// max no. of items per page
$pagesize = 10;

// URL data
// show_array($_REQUEST);
$titleID      = array_item($_REQUEST, 'titleID');
$authID       = array_item($_REQUEST, 'authID');
$catID        = array_item($_REQUEST, 'catID');
$authPattern  = urldecode(array_item($_REQUEST, 'authPattern'));
$titlePattern = urldecode(array_item($_REQUEST, 'titlePattern'));
$page         = array_item($_REQUEST, 'page');

// validity
if(!$page || $page<1 || !is_numeric($page))
  $page=1;
elseif($page>100)
  $page=100;
if(!is_numeric($catID))
  $catID = FALSE;
if(!is_numeric($authID))
  $authID = FALSE;
if(!is_numeric($titleID))
  $titleID = FALSE;

// form data
$formdata = array_item($_POST, "form");
if(is_array($formdata)) {
  // get rid of magic quotes
  if(get_magic_quotes_gpc())
    while($i = each($formdata))
      $formdata[$i[0]] = stripslashes($i[1]);
  // show_array($formdata);
  $authPattern  = array_item($formdata, "author") . "%";
  if(!array_item($formdata, "btnAuthor")) {
    $catID        = array_item($formdata, "category");
    $titlePattern = array_item($formdata, "title") . "%"; }
}

// start title/author search
// note: if $titlePattern and $authPattern both contain
// text, $authPattern is simply ignored
if($titlePattern || $titleID || $catID) {
  // title query
  $sql = build_title_query($titlePattern, $titleID, $catID,
    $page, $pagesize);
  $rows = $db->queryObjectArray($sql);
  show_titles($rows, $pagesize);
  $query = "catID=$catID&titleID=$titleID&titlePattern=" .
    urlencode($titlePattern);
  show_page_links($page, $pagesize, sizeof($rows), $query);
  echo '<p><a href="find.php">Back to search form</a></p>', "\n";
}
elseif($authPattern || $authID) {
  // author query
  $sql = build_author_query($authPattern, $authID, $page, $pagesize);
  $rows = $db->queryObjectArray($sql);
  show_authors($rows, $pagesize);
  $query = "authID=$authID&authPattern=" . urlencode($authPattern);
  show_page_links($page, $pagesize, sizeof($rows), $query);
  echo '<p><a href="find.php">Back to search form</a></p>', "\n";
}
else {
  // nothing to do, show query form
  echo "<h1>Search titles/authors in mylibrary</h1>\n";
  build_form();
  // link to input and category forms
  printf("<p><br />%s<br />%s</p>\n",
    build_href("titleform.php", "", "Input new title"),
    build_href("categories.php", "", "Edit categories"));
}

// $db->statistics();

?>
</body></html>


<?php    // functions

// show query form
function build_form($formdata=FALSE) {
  global $db;

  // title form
  form_start("find.php");
  form_new_line();
  form_label("Title starts with");
  form_text("title", array_item($formdata, "title"), 10, 10);
  form_end_line();

  form_new_line();
  form_label("Only for this category");
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
  form_list("category", $rows , FALSE);
  form_end_line();

  form_new_line();
  form_label("");
  form_button("btnTitle", "Search for titles");
  form_end_line();

  // authors form
  form_new_line();
  form_label("Author starts with");
  form_text("author", array_item($formdata, "author"), 10, 10);
  form_end_line();

  form_new_line();
  form_label("");
  form_button("btnAuthor", "Search for authors");
  form_end_line();
  form_end();
}

// build SQL string to query for titles
function build_title_query($pattern, $titleID, $catID, $page, $size) {
  global $db;
  $sql = "SELECT titleID, title FROM titles ";
  if($titleID)
    // we are already done
    return $sql . "WHERE titleID=$titleID ORDER BY title";

  // add conditions for category search and pattern search
  if($catID && $catID!="none") {
    $catsql = "SELECT catID, parentCatID FROM categories";
    $rows = $db->queryObjectArray($catsql);
    foreach($rows as $row)
      $subcats[$row->parentCatID][] = $row->catID;
    $cond1 = "catID IN (" . subcategory_list($subcats, $catID) . ") "; }
  else
    $cond1 = "TRUE";
  if($pattern)
    $cond2 = "title LIKE " . $db->sql_string($pattern) . " ";
  else
    $cond2 = "TRUE";
  $sql .= "WHERE " . $cond1 . " AND " . $cond2 .
    " ORDER BY title ";

  // add limit clause
  $sql .= "LIMIT " . (($page-1) * $size) . "," . ($size + 1);
  return $sql;
}

// returns comma-separated list including $catID and
// all subcategories
function subcategory_list($subcats, $catID) {
  $lst = $catID;
  if(array_key_exists($catID, $subcats))
    foreach($subcats[$catID] as $subCatID)
      $lst .= ", " . subcategory_list($subcats, $subCatID);
  return $lst;
}



// build SQL string to query for authors
function build_author_query($pattern, $authID, $page, $size) {
  global $db;

  $sql = "SELECT authID, authName FROM authors ";
  if($authID)
    // we are done
    return $sql . "WHERE authID = $authID";
  else
    return $sql ."WHERE authName LIKE " . $db->sql_string($pattern) .
      " ORDER BY authNAME " .
      "LIMIT " . (($page-1) * $size) . "," . ($size + 1);
}

// $titles is an object array;
// each object has an authId and an authName item
function show_titles($titles, $pagesize) {
  global $db;

  echo "<h1>Search results</h1>\n";
  if(!$titles) {
    echo "<p>Sorry, no titles found.</p>\n";
    return; }

  // build comma-separated string with titleIDs
  $items = min($pagesize, sizeof($titles));
  for($i=0; $i<$items; $i++)
    if($i==0)
      $titleIDs = $titles[$i]->titleID;
    else
      $titleIDs .= "," . $titles[$i]->titleID;

  // get all title data (no authors)
  $sql =
    "SELECT titleID, title, subtitle, year, edition, isbn, " .
    "langName, catID, publName " .
    "FROM titles " .
    "  LEFT JOIN languages  ON titles.langID = languages.langID " .
    "  LEFT JOIN publishers ON titles.publID = publishers.publID " .
    "WHERE titleID IN ($titleIDs) " .
    "ORDER BY title";
  $titlerows = $db->queryObjectArray($sql);

  // get the authors for these titles
  $sql =
    "SELECT authName, rel_title_author.authID, titleID " .
    "FROM authors, rel_title_author ".
    "WHERE authors.authID = rel_title_author.authID " .
    "  AND rel_title_author.titleID IN ($titleIDs) " .
    "ORDER BY authName";
  $rows = $db->queryObjectArray($sql);
  // build assoc. array for fast access to authors
  foreach($rows as $author)
    $authors[$author->titleID][] =
      array($author->authName, $author->authID);

  // get all categories to show categories
  $sql = "SELECT catName, catID, parentCatID FROM categories";
  $rows = $db->queryObjectArray($sql);
  // build assoc. array for fast access to category names and parent cats
  foreach($rows as $cat) {
    $catNames[$cat->catID] = $cat->catName;
    $catParents[$cat->catID] = $cat->parentCatID; }

  // show all titles in a table
  echo '<table class="resulttable">', "\n";
  foreach($titlerows as $title) {
    echo td1("Title:", "td1head");
    $html = htmlspecial_utf8($title->title) . " " .
      build_href("titleform.php", "editID=$title->titleID", "(edit)");
    echo td2asis($html, "td2head");
    if($title->subtitle)
      echo td1("Subtitle:"), td2($title->subtitle);

    // show all authors for this title
    if(array_key_exists($title->titleID, $authors)) {
      $auth=0;
      foreach($authors[$title->titleID] as $author) {
        if($auth==0)
          echo td1("Author[s]:");
        else
          echo td1("");
        echo td2url($author[0], "find.php?authID=$author[1]");
        $auth++;
      }
    }
    // echo "</td></tr>\n";

    // if available, show more title information
    if($title->catID)
      echo td1("Category:"),
        td2asis(build_cat_string($catNames, $catParents, $title->catID));
    if($title->publName)
      echo td1("Publisher:"), td2($title->publName);
    if($title->isbn)
      echo td1("ISBN:"), td2($title->isbn);
    if($title->edition)
      echo td1("Edition:"), td2($title->edition);
    if($title->langName)
      echo td1("Language:"), td2($title->langName);
    // show empty line before next title
    echo td1("", "tdinvisible"), td2asis("&nbsp;", "tdinvisible");
  }
  echo "</table>\n";
}

// returns a string with URLs to $catID an all
// higher level categories
function build_cat_string($catNames, $catParents, $catID) {
  $tmp = build_href("find.php", "catID=$catID", $catNames[$catID]);
  while($catParents[$catID] != NULL) {
    $catID = $catParents[$catID];
    $tmp = build_href("find.php", "catID=$catID", $catNames[$catID]) .
      " &rarr; " . $tmp; }
  return $tmp;
}

// $authors is an object array;
// each object has an authId and an authName item
function show_authors($authors, $pagesize) {
  global $db;

  echo "<h1>Search results</h1>\n";
  if(!$authors) {
    echo "<p>Sorry, no authors found.</p>\n";
    return; }

  // build comma-separated string with authIDs
  $items = min($pagesize, sizeof($authors));
  for($i=0; $i<$items; $i++)
    if($i==0)
      $authIDs = $authors[$i]->authID;
    else
      $authIDs .= "," . $authors[$i]->authID;

  // get all titles these authors have written
  $sql = "SELECT title, rel_title_author.titleID, authID " .
    "FROM titles, rel_title_author ".
    "WHERE titles.titleID = rel_title_author.titleID " .
    "AND rel_title_author.authID IN ($authIDs) " .
    "ORDER BY title";
  $rows = $db->queryObjectArray($sql);

  // process all authors, show all titles for each author
  echo '<table class="resulttable">', "\n";
  for($i=0; $i<$items; $i++) {
    echo td1("Author:", "td1head"),
      td2($authors[$i]->authName, "td2head");
    $titles=0;
    foreach($rows as $row)
      if($authors[$i]->authID == $row->authID) {
        if($titles==0)
          echo td1("Titles[s]:");
        else
          echo td1("");
        echo td2url($row->title, "find.php?titleID=$row->titleID");
        $titles++;
      }
    // show empty line before next title
    echo td1("", "tdinvisible"), td2asis("&nbsp;", "tdinvisible");
  }
  echo "</table>\n";
}

// help building result table
function td1($txt, $class="td1") {
  echo "<tr><td class=\"$class\">",
    htmlspecial_utf8($txt), "</td>\n"; }
function td2($txt, $class="td2") {
  echo "<td class=\"$class\">",
    htmlspecial_utf8($txt), "</td></tr>\n"; }
function td2asis($txt, $class="td2") {
  echo "<td class=\"$class\">$txt</td></tr>\n"; }
function td2url($txt, $url, $class="td2") {
  echo "<td class=\"$class\">",
    build_href($url, "", $txt), "</td></tr>\n"; }
function td2txturl($txt, $urltxt, $url, $class="td2") {
  echo "<td class=\"$class\">",
    htmlspecial_utf8($txt), " ",
    build_href($url, "", $urltxt), "</td></tr>\n"; }

// show links to previos/next page
// $page     .. current page no.
// $pagesize .. max. no. of items per page
// $results  .. no. of search results
function show_page_links($page, $pagesize, $results, $query) {
  if(($page==1 && $results<=$pagesize) || $results==0)
    // nothing to do
    return;
  echo "<p>Goto page: ";
  if($page>1) {
    for($i=1; $i<$page; $i++)
      echo build_href("find.php", $query . "&page=$i", $i), " ";
    echo "$page "; }
  if($results>$pagesize) {
    $nextpage = $page + 1;
    echo build_href("find.php", $query . "&page=$nextpage", $nextpage);
  }
  echo "</p>\n";
}

?>
