<?php  // functions for sp administrator
require_once 'spfunctions.php';
require_once 'formfunctions.php';
require_once 'password.php';

// for PHP 5.0.2
$mysqli = mysqli_init();
$mysqli->real_connect($mysqlhost, $mysqluser, $mysqlpasswd);

// beginning with PHP 5.0.3 also works:
// $mysqli = @new mysqli($mysqlhost, $mysqluser, $mysqlpasswd);

if(mysqli_connect_errno()) {
  html_start('MySQL connection error');
  printerror("Sorry, no connection! (" . mysqli_connect_error() . ")");
  html_end();
  exit(); }

ini_set('session.use_trans_sid', 1);
session_start();
// print_r($_SESSION);

// process form data and save it into $_SESSION array, so it
// stays available
$execute_cmd=FALSE;
$formdata = array_item($_POST, "form");
if(is_array($formdata)) {
  if(get_magic_quotes_gpc())    // get rid of magic quotes
    while($i = each($formdata))
      $formdata[$i[0]] = stripslashes($i[1]);

  if(array_item($formdata, 'btnSelectDB')) {
    $_SESSION['dbname'] = array_item($formdata, 'dbname');
    $_SESSION['spname'] = FALSE;
    $_SESSION['action'] = FALSE;
    $_SESSION['cmd'] = FALSE; }

  if(array_item($formdata, 'btnAction')) {
    $_SESSION['spname'] = array_item($formdata, 'spname');
    $_SESSION['action'] = array_item($formdata, 'action');
    $_SESSION['cmd'] = FALSE; }

  if(array_item($formdata, 'btnExecute'))  {
    $_SESSION['cmd'] = array_item($formdata, 'cmd');
    $execute_cmd=TRUE; }

  // restore SPs
  if(array_item($formdata, 'btnRestore')) {
    $spfile  = array_item($_FILES, 'spfile');
    if($spfile && is_array($spfile)){
      $uperr   = $spfile['error'];    // Fehlernummer (0 = kein Fehler)
      $tmpfile = $spfile['tmp_name']; // Name der lokalen, temporären Datei
      $size    = $spfile['size'];
      if(!$uperr && $size>0 && $tmpfile && is_uploaded_file($tmpfile)) {
        $file = fopen($tmpfile, "rb");  // Datei öffnen (read-only, binär)
        $sql  = fread($file, $size);    // Datei lesen
        fclose($file);
        restore_sps($mysqli, $sql);
      }
    }
    $_SESSION['action'] = FALSE;
  }
}

// read all available information from $_SESSION to
// dbname, spname, type, action, cmd and execute_cmd
$dbname = array_item($_SESSION, 'dbname');
if($dbname=="none")
  $dbname=FALSE;

$spname = array_item($_SESSION, 'spname');
if($spname=="none") {
  $spname = FALSE;
  $type   = FALSE; }
else {  // spname is in form FUNCTION_fname or PROCEDURE_spname
  $pos    = strpos($spname, '_');
  $type   = substr($spname, 0, $pos);  // FUNCTION or PROCEDURE
  $spname = substr($spname, $pos+1); } // name only

$action = array_item($_SESSION, 'action');
if($action=="none")
  $action=FALSE;

$cmd = array_item($_SESSION, 'cmd');
if(trim($cmd)=="") {
  $cmd=FALSE;
  $execute_cmd=FALSE; }

if($action=='backup') {
  header("Location: " . baseurl() . "/backup.php?dbname=" . urlencode($dbname));
  exit;
}


// start output
html_start();

// execute create/alter commands and show results
if($execute_cmd) {
  if($action=="newf" || $action=="newp") {
    echo "<h3>Create SP / function</h3>\n";
    printsql($cmd);
    $ok = execute($mysqli, $cmd);
    if($ok) {
      echo "<font color=\"#00cc00\">OK</font>\n";
      $cmd = FALSE;
      $_SESSION['cmd']=FALSE;
      $action = FALSE;
      $_SESSION['action'] = FALSE; }
  }
  elseif($action=="alter") {
    echo "<h3>Change SP / function</h3>\n";
    // first drop
    if($type=="FUNCTION")
      $sql = "DROP FUNCTION IF EXISTS $dbname.$spname";
    else
      $sql = "DROP PROCEDURE IF EXISTS $dbname.$spname";
    printsql($sql);
    $ok = execute($mysqli, $sql);
    if($ok) echo "<font color=\"#00cc00\">OK</font>\n";

    // then re-create
    printsql($cmd);
    $ok = execute($mysqli, $cmd);
    if($ok) echo "<font color=\"#00cc00\">OK</font>\n";
  }
}

// drop SP
if($action=='delete'  && $spname) {
  echo "<h3>Delete this stored procedure</h3>\n";
  if($type=="FUNCTION")
    $sql = "DROP FUNCTION $dbname.$spname";
  else
    $sql = "DROP PROCEDURE $dbname.$spname";
  printsql($sql);
  $ok = execute($mysqli, $sql);
  if($ok) echo "<font color=\"#00cc00\">OK</font>\n";
  $cmd = FALSE;
  $_SESSION['cmd']=FALSE;
  $spname = FALSE;
  $_SESSION['spname'] = FALSE;
}

// show database selection form
echo "<h3>First choose a database</h3>\n";
show_db_form($mysqli, $_SESSION);

if($dbname) {
  // show form to choose SP and action
  echo "<h3>Then choose what to do</h3>\n";
  show_sp_form($mysqli, $_SESSION, $dbname);

  // show SQL command input form
  if($action=='newf' || $action=='newp') {
    echo "<h3>Create a new stored procedure / function</h3>\n";
    show_cmd_form($mysqli, $_SESSION, $dbname, $spname, $type, $action);  }
  if($action=='restore') {
    echo "<h3>Restore SPs</h3>\n";
    show_restore_form($mysqli, $dbname);  }
  elseif($action=='alter' && $spname) {
    echo "<h3>Alter this stored procedure</h3>\n";
    show_cmd_form($mysqli, $_SESSION, $dbname, $spname, $type, $action);  }
  elseif($action=='call'  && $spname) {
    echo "<h3>Call (execute) this stored procedure</h3>\n";
    show_cmd_form($mysqli, $_SESSION, $dbname, $spname, $type, $action);  }
}

// call (execute) SP or function and show results
if($execute_cmd && $action=="call") {
  test_sp($mysqli, $dbname, $cmd);
}

html_end();
exit;

?>