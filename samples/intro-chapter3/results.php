<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN">
<!-- results.php -->
<html><head>
  <meta http-equiv="Content-Type" 
        content="text/html; charset=iso-8859-1" />
  <title>Results</title>
</head><body>
<h2>Results</h2>
<?php

  $mysqlhost="localhost";
  $mysqluser="root";
  $mysqlpasswd="";
  $mysqldbname="test_vote";

  // connect to database
  $link = 
    @mysql_connect($mysqlhost, $mysqluser, $mysqlpasswd);
  if ($link == FALSE) {
    echo "<p><b>Unfortunately it is not possible to 
          connect to the database. Therefore the results
          cannot be shown now. Please try again later.
          </b></p></body></html>\n";
    exit();
  }
  mysql_select_db($mysqldbname);  
  
  // if form data is available: process and save
  function array_item($ar, $key) {
    if(array_key_exists($key, $ar)) return($ar[$key]);
    return('');  }

  $submitbutton = array_item($_POST, 'submitbutton');
  $vote = array_item($_POST, 'vote');

  if($submitbutton=="OK") {
    if($vote>=1 && $vote<=6) {
      mysql_query(
        "INSERT INTO votelanguage (choice) VALUES ($vote)");
    } 
    else {
      echo "<p>No valid choice. Please vote again. 
            Back to the 
            <a href=\"vote.html\">voting form</a>.</p>
            </body></html>\n";
      exit();
    }
  }
  
  // show results
  echo "<p><b>What is your favorite programming language 
      for developing MySQL applications?</b></p>\n";

  // number of total votes
  $result  = 
    mysql_query("SELECT COUNT(choice) FROM votelanguage");
  $choice_count = mysql_result($result, 0, 0);

  // percentages for each choice
  if($choice_count == 0) {
    echo "<p>No one has voted yet.</p>\n";
  } 
  else {
    echo "<p>$choice_count persons have voted:</p>\n";
    $choicetext = array("", "C/C++", "Java", "Perl", "PHP", 
                        "VB/VBA/VBScript", "Other");
    print("<p><table>\n");
    for($i=1; $i<=6; $i++) {
      $result  = mysql_query(
        "SELECT COUNT(choice) FROM votelanguage " . 
        "WHERE choice = $i");
      $choice[$i] = mysql_result($result, 0, 0); 
      $percent = round($choice[$i]/$choice_count*10000)/100;
      print("<tr><td>$choicetext[$i]:</td>");
      print("<td>$percent %</td></tr>\n");
    }
    print("</table></p>\n");
  }
?>
</body>
</html>
