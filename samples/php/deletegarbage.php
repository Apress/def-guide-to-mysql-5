<?php

// deletes unused authors and publishers
// deletes titles without authors
// clears rel_title_author from unused/wrong entries

require_once("mydb.php");
$db = new MyDb();

$sql = "DELETE FROM rel_title_author " .
       "WHERE authID NOT IN (SELECT authID FROM authors) " .
       "  OR titleID NOT IN (SELECT titleID FROM titles)";
$db->execute($sql);

$sql = "DELETE FROM authors " .
       "WHERE authID NOT IN (SELECT authID FROM rel_title_author)";
$db->execute($sql);

$sql = "DELETE FROM publishers WHERE publID NOT IN (SELECT publID FROM titles)";
$db->execute($sql);

$sql = "DELETE FROM titles " .
       "WHERE titleID NOT IN (SELECT titleID FROM rel_title_author)";
$db->execute($sql);

$sql = "DELETE FROM rel_title_author " .
       "WHERE authID NOT IN (SELECT authID FROM authors) " .
       "  OR titleID NOT IN (SELECT titleID FROM titles)";
$db->execute($sql);

?>