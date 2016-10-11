#!/usr/bin/perl -w
# mylibrary-simpleinput.pl

use strict;
use DBI;
use CGI qw(:standard);
use CGI::Carp qw(fatalsToBrowser);

# variables
my($datasource, $user, $passw, $dbh, @row,
   $formTitle, $formAuthors, $titleID, $authID, $author);

# connect to the database
$datasource   = "DBI:mysql:database=mylibrary;host=localhost;";
$user  = "root";
$passw = "uranus";
$dbh = DBI->connect($datasource, $user, $passw,
  {'PrintError' => 0});

if(DBI->err()) {
  print header(),
    start_html("Sorry, no database connection"), 
    p("Sorry, no database connection"), 
    end_html(); 
  exit();
}

# tell MySQL we communicate using latin1
$dbh->do("SET NAMES 'latin1'");

# print HTML header
print header(),
    start_html("Perl programming, simple input form for the mylibrary database"), "\n",
    h2("Input a new title for the mylibrary database"), "\n";

# process form input (if available)
if(param()) {
  $formTitle = param('formTitle');
  $formAuthors = param('formAuthors');

  # validate input
  if($formTitle eq "" || $formAuthors eq "") {
    print p(), b("Please specify title and at least one author!"); }

  # input seems to be ok; save in mylibrary database
  else {
    # save title
    $dbh->do("INSERT INTO titles (title) VALUES (?)", undef, ($formTitle));
    $titleID = $dbh->{'mysql_insertid'};

    # save authors
    foreach $author (split(/;/, $formAuthors)) {
      # first test whether author already exists in database
      @row = $dbh->selectrow_array("SELECT authID FROM authors " .
                                   "WHERE authName = " . $dbh->quote($author));
      # author alread exists; get existing authID
      if(@row) {
        $authID = $row[0]; }
      # author does not exist: save author, get new authID
      else {
        $dbh->do("INSERT INTO authors (authName) VALUES (?)", undef, ($author));
        $authID = $dbh->{'mysql_insertid'};
      }
      # save rel_title_author entry
      $dbh->do("INSERT INTO rel_title_author (titleID, authID) " .
               "VALUES ($titleID, $authID)");
    }

    # show link back to input form
    print p(), "Your last input has been saved.";
    print br(), "You may now continue with the next title.";

    # empty form
    param(-name=>'formTitle', -value=>'');
    param(-name=>'formAuthors', -value=>'');
  }
}

# show form
print start_form(),
    p(), "Title:", 
    br(), 
    textfield({-name => 'formTitle', -size => 60, 
               -maxlength => 80}), "\n",
    p(), "Authors:",
    br(),
    textfield({-name => 'formAuthors', -size => 60, 
               -maxlength => 100}), "\n",
    br(), 
    "(Last name first! If you want to specify more ",
    "than one author, use ; to separate them!)", "\n",
    p(),
    submit({-name => 'formSubmit', -value => 'OK'}),
    end_form(), "\n";

# show link to mylibrary-find.pl
print p(), 'Goto ', a({-href=>'mylibrary-find.pl'}, 'mylibrary-find'), "\n";

# end
print end_html();
$dbh->disconnect();
