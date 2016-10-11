<?php  // functions for sp administrator

$separator = "$$";

// html header
function html_start($title="SP-Administrator", $css="sp.css") {
  echo '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"',
       '"http://www.w3.org/TR/html4/loose.dtd">', "\n",
       '<html><head>',
       '<meta http-equiv="Content-Type"',
       '      content="text/html; charset=iso-8859-1" />', "\n";
  if($css)
    printf('<link href="%s" rel="stylesheet" type="text/css">', $css);
  printf("<title>%s</title>\n</head><body>\n",
         htmlentities($title));
}

// html footer
function html_end() {
  echo "</body></html>\n";
}

// show form to choose a database
function show_db_form($mysqli, $formdata) {
  form_start("spadmin.php");
  form_new_line();
  form_label("Select database:");
  $sql = "SHOW databases";
  $rows = queryArray($mysqli, $sql);
  $i = 0;
  foreach($rows as $row) {
    $dbs[$i][0]   = $row[0];    // name
    $dbs[$i++][1] = $row[0]; }  // id
  form_list("dbname", $dbs, array_item($formdata, "dbname"),
            "[please choose a database]");
  form_button("btnSelectDB", "OK");
  form_end_line();
  form_end();
}

// show form to choose an action and a SP or function
function show_sp_form($mysqli, $formdata, $dbname) {
  form_start("spadmin.php");
  form_new_line();
  form_label("Select Action:");
  $rows = array(array('ALTER  an existing SP/function', 'alter'),
                array('CALL   a procedure/function', 'call'),
                array('CREATE a new procedure', 'newp'),
                array('CREATE a new function', 'newf'),
                array('DROP   a procedure/function', 'delete'),
                array('---', 'donothing'),
                array('Backup all SPs', 'backup'),
                array('Restore SPs', 'restore'));
  form_list("action", $rows, $formdata["action"], "[choose an action]");
  form_empty_cell();
  form_end_line();

  form_new_line();
  form_label("Select SP:");
  $sql = "SELECT 
            CONCAT(routine_name, '  (', routine_type, ')') 
              AS displayname,
            CONCAT(routine_type, '_', routine_name) 
              AS internalname
          FROM information_schema.routines 
          WHERE routine_schema = '$dbname'
          ORDER BY displayname";
  $rows = queryArray($mysqli, $sql);
  form_list("spname", $rows, array_item($formdata, "spname"),
            "[choose a SP]");
  form_button("btnAction", "OK");
  form_end_line();
  form_end();
}

// show form to edit a SQL command
function show_cmd_form($mysqli, $formdata, $dbname, $spname, $type, $action) {
  $no_of_rows = 20;  // lines in textarea for SQL cmd
  form_start("spadmin.php");
  form_new_line();
  if($action == "alter") {
    if($type=="FUNCTION") {
      $sql  = "SHOW CREATE FUNCTION $dbname.$spname";
      $rows = queryArray($mysqli, $sql);
      $cmd  = $rows[0]["Create Function"]; }
    else {
      $sql  = "SHOW CREATE PROCEDURE $dbname.$spname";
      $rows = queryArray($mysqli, $sql);
      $cmd  = $rows[0]["Create Procedure"]; }
    form_new_line();
    form_caption("Warning: MySQL can not directly change the code of an exisiting
                  procedure. Therefore, if you execute the following command, the
                  procedure $dbname.$spname will first be dropped. Don't use this
                  form if you want to create a new procedure similar to an existing
                  one; you would loose your existing procedure!");
    form_end_line();
  } elseif($action == "newp") {
    $cmd="CREATE PROCEDURE $dbname.<myspname> (<myparameters>)\nBEGIN\n  <mycode>\nEND";
  } elseif($action == "newf") {
    $cmd="CREATE FUNCTION $dbname.<myfname> (<myparameters>) RETURNS <mytype>\n" .
         "BEGIN\n  <mycode>\n\n  RETURN <myresult>\nEND";
  } elseif($action == "call") {
    if($type=="FUNCTION") {
      $sql  = "SHOW CREATE FUNCTION $dbname.$spname";
      $rows = queryArray($mysqli, $sql);
      $code  = $rows[0]["Create Function"];
      $cmd="SELECT $dbname.$spname (<myparameters>)"; }
    else {
      $sql  = "SHOW CREATE PROCEDURE $dbname.$spname";
      $rows = queryArray($mysqli, $sql);
      $code = $rows[0]["Create Procedure"];
      $cmd="CALL $dbname.$spname (<myparameters>)"; }
    form_new_line();
    form_asis("<b>This is the code of the procedure you want to call:</b>" .
              "<br /><br />" .
              str_replace(" ", "&nbsp;", nl2br(htmlspecialchars(substr($code, 7)))) .
              "<br /><br />You may separate several SQL commands with a semicola.");
    form_end_line();
    $no_of_rows = 5;
  }


  if(array_item($formdata, "cmd"))
    $cmd = array_item($formdata, "cmd");
  form_new_line();
  form_textarea("cmd", $cmd, 70, $no_of_rows);
  form_end_line();

  if($action != 'backup') {
    form_new_line();
    form_button("btnExecute", "Execute command");
    form_end_line(); }
  form_end();
}

function show_restore_form($mysqli, $dbname) {
  form_start("spadmin.php", "post", "multipart/form-data");
  echo '<input type="hidden" name="MAX_FILE_SIZE" value="100000" />', "\n";
  form_new_line();
  form_caption("Choose file:");
  form_file("spfile");
  form_end_line();

  form_new_line();
  form_empty_cell();
  form_button("btnRestore", "Restore");
  form_end_line();
  form_end();
}

// return string with DROP and CREATE commands for all SPs for the given database
function backup_sps($mysqli, $dbname) {
  global $separator;

  $sep    = $separator . "\n";
  $result = "DELIMITER $sep";
  $sql    = "SELECT routine_name, routine_type
             FROM information_schema.routines 
             WHERE routine_schema = '$dbname'";
  $rows   = queryArray($mysqli, $sql);
  foreach($rows as $row) {
    $spname = $row[0];
    $type = $row[1];
    if($type=="FUNCTION") {
      $sql     = "SHOW CREATE FUNCTION $dbname.$spname";
      $create  = queryArray($mysqli, $sql);
      $result .= "DROP FUNCTION IF EXISTS $dbname.$spname" . $sep .
                 $create[0]["Create Function"] . $sep;
    }
    else {
      $sql     = "SHOW CREATE PROCEDURE $dbname.$spname";
      $create  = queryArray($mysqli, $sql);
      $result .= "DROP PROCEDURE IF EXISTS $dbname.$spname" . $sep .
                 $create[0]["Create Procedure"] . $sep;
    }
  }
  $result .= "DELIMITER ;\n";
  return $result;
}

function restore_sps($mysqli, $sql) {
  global $separator;

  echo "<h3>Restore SPs</h3>\n";
  $cmds = explode($separator, $sql);
  foreach($cmds as $cmd)
    if(trim($cmd)!="" && strpos($cmd, "DELIMITER")===FALSE) {
      printsql($cmd);
      $ok = execute($mysqli, $cmd);
      if($ok) echo "<font color=\"#00cc00\">OK</font>\n";}
}

function test_sp($mysqli, $dbname, $cmd) {
  echo "<h3>Results of SQL command(s)</h3>\n";
  $mysqli->select_db($dbname);
  printsql($cmd);
  $ok = $mysqli->multi_query($cmd);
  if($mysqli->info)
    printerror("Info: " . $mysqli->info);
  if($mysqli->warning_count)
    printerror("Warnings: " . $mysqli->warning_count);
  if($mysqli->errno)
    printerror("Error: " . $mysqli->error);

  if($ok) {
    do {
      $result = $mysqli->store_result();
      if($result) {
        show_table($result);
        $result->close();
      }
      $next = $mysqli->next_result();
      // echo "<p>next=$next</p>\n";
    } while($next);
  }
}

// mysqli helper functions

// execute SQL command
function execute($mysqli, $sql) {
  $result = $mysqli->real_query($sql);
  if($result)
    return TRUE;
  else {
    printerror($mysqli->error);
    return FALSE; }
}

// process SQL query, return array with results or FALSE
function queryArray($mysqli, $sql) {
  $result = $mysqli->query($sql);
  if($result) {
    if($result->num_rows) {
      while($row = $result->fetch_array())
        $result_array[] = $row;
      return $result_array; }
    else
      return FALSE;
  } else {
    printerror($mysqli->error);
    return FALSE; }
}

// show SELECT result
function show_table($result) {
  if($result->num_rows>0 && $result->field_count>0) {
    echo "<p><table class=\"mytable\">";
    // column headings
    echo "<tr>";
    foreach($result->fetch_fields() as $meta)
      printf("<th class=\"myth\">%s</th>", htmlentities($meta->name));
    echo "</tr>\n";

    // content
    while($row = $result->fetch_row()) {
      echo "<tr>";
      foreach($row as $col)
        printf("<td class=\"mytd\">%s</td>",
          str_replace(" ", "&nbsp;", nl2br(htmlentities($col))));
      echo "</tr>\n";
    }
    echo "</table></p>\n";
  }
}

// -------- trivial helper functions

function printsql($sql) {
  printf("<p><font color=\"#0000ff\" size=\"-1\">%s</font></p>\n",
         str_replace(" ", "&nbsp;", nl2br(htmlentities($sql))));    }

function printerror($txt) {
  printf("<p><font color=\"#ff0000\">%s</font></p>\n",
    htmlentities($txt));  }

// test, if array item exists, and return it
function array_item($ar, $key) {
  if(is_array($ar) && array_key_exists($key, $ar))
    return($ar[$key]);
  else
    return FALSE;
}

// build <a href=$url?$query>$txt</a>
function build_href($url, $query, $txt) {
  if($query)
    return "<a href=\"$url?" . $query . "\">" . htmlentities($txt) . "</a>";
  else
    return "<a href=\"$url\">" . htmlentities($txt) . "</a>";
}

// return http://<thiswebsite>/<thisdirectory>
function baseurl() {
  return "http://" . $_SERVER['HTTP_HOST'] .
         dirname($_SERVER['PHP_SELF']);
}


?>
