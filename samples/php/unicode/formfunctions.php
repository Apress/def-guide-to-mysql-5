<?php  // functions to build forms
       // used by categories.php, titleform.php, search.php

// read function htmlspecial_utf8
require_once 'mylibraryfunctions.php'; 

// start form; use table to align form entries
function form_start($action) {
  echo '<table class="myformtable">', "\n";
  echo '<form method="post" ',
    html_attribute("action", $action), ">\n"; }

// close form
function form_end() {
  echo "</form></table>\n\n"; }

// new line (row) in table
function form_new_line() {
  echo "<tr>"; }

// end line (row)
function form_end_line() {
  echo "</tr>\n\n"; }

// show right-aligned text in form cell
function form_label($caption, $necessary=FALSE) {
  echo '<td align="right" class="myformtd">';
  if($necessary)
    echo '<span class="red">', htmlspecial_utf8($caption), '</span>';
  else
    echo htmlspecial_utf8($caption);
  echo '</td>', "\n";
}

// show text in form cell
function form_caption($caption, $colspan=1) {
  if($colspan>1)
    echo '<td class="myformtd" ',
      html_attribute("colspan", $colspan), '>';
  else
    echo '<td class="myformtd">';
  echo htmlspecial_utf8($caption), '</td>', "\n";
}

// show text as is in form cell
function form_asis($txt, $colspan=1) {
  if($colspan>1)
    echo '<td class="myformtd" ',
      html_attribute("colspan", $colspan), '>';
  else
    echo '<td class="myformtd">';
  echo $txt, '</td>', "\n";
}

// show URL in form cell
function form_url($url, $txt, $colspan=1) {
  if($colspan>1)
    echo '<td class="myformtd" ',
      html_attribute("colspan", $colspan), '>';
  else
    echo '<td class="myformtd">';
  echo "<a href=\"$url\">" . htmlspecial_utf8($txt) . "</a></td>\n";
}

// save hidden data in form
function form_hidden($name, $value) {
  echo '<input type="hidden" ',
    html_attribute("name", "form[$name]"),
    html_attribute("value", $value),
    " />\n";
}

// create $n empty cells
function form_empty_cell($n=1) {
  echo str_repeat('<td class="myformtd">&nbsp;</td>', $n) . "\n";
}

// create text input field for form
function form_text($name, $value, $size=40, $maxlength=40, $colspan=1) {
  if($colspan>1)
    echo '<td class="myformtd" ',
      html_attribute("colspan", $colspan), '>';
  else
    echo '<td class="myformtd"> ';
  echo '<input class="mycontrol" ',
    html_attribute("name", "form[$name]"),
    html_attribute("size", $size),
    html_attribute("maxlength", $maxlength);
  if($value)
    echo html_attribute("value", $value);
  echo ' /></td>', "\n";
}

// create text input field for form
function form_password($name, $value, $size=40, $maxlength=40, $colspan=1) {
  if($colspan>1)
    echo '<td class="myformtd" ',
      html_attribute("colspan", $colspan), '>';
  else
    echo '<td class="myformtd"> ';
  echo '<input class="mycontrol" ',
    html_attribute("type", "password"),
    html_attribute("name", "form[$name]"),
    html_attribute("size", $size),
    html_attribute("maxlength", $maxlength);
  if($value)
    echo html_attribute("value", $value);
  echo ' /></td>', "\n";
}

// create text input field for form
function form_textarea($name, $value, $cols=70, $rows=6, $colspan=1) {
  if($colspan>1)
    echo '<td class="myformtd" ',
      html_attribute("colspan", $colspan), '>';
  else
    echo '<td class="myformtd"> ';
  echo '<textarea class="mycontrol" ',
    html_attribute("name", "form[$name]"),
    html_attribute("rows", $rows),
    html_attribute("cols", $cols), '>';
  if($value)
    echo htmlspecial_utf8($value);
  echo '</textarea></td>', "\n";
}

// create select list
function form_list($name, $rows, $selected=-1) {
  echo '<td class="myformtd">';
  echo '<select class="mycontrol" ',
    html_attribute("name", "form[$name]"), '>', "\n";
  echo '<option value="none">(choose)</option>';
  foreach($rows as $row) {
    echo '<option ', html_attribute("value", $row[1]);
    if($selected==$row[1])
      echo 'selected="selected" ';
    $listentry = str_replace(" ", "&nbsp;", htmlspecial_utf8($row[0]));
    echo ">$listentry</option>\n";
  }
  echo '</select></td>', "\n";
}

// create form button
function form_button($name, $txt, $type="submit") {
  echo '<td class="myformtd"><input ',
    html_attribute("class", "mybutton"),
    html_attribute("type", $type),
    html_attribute("value", $txt),
    html_attribute("name", "form[$name]"),
    ' /></td>', "\n";
}

// build name="value"
function html_attribute($name, $value) {
  return $name . '="' . htmlspecial_utf8($value) . '" ';
}

// show red error message
function show_error_msg($txt) {
  echo '<p><span class="red">', htmlspecial_utf8($txt), '</span></p>', "\n";
}


 ?>
