#!/usr/bin/perl -w
# mylibrary-simpleinput-utf8.pl

use strict;
use DBI;
use CGI qw(:standard);
use CGI::Carp qw(fatalsToBrowser);
use Encode qw(decode);

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

# tell MySQL we communicate using utf8
$dbh->do("SET NAMES 'utf8'");

# print HTML header
print header(-type => "text/html",  -charset => "utf8"),
    start_html(-encoding => 'utf-8',
      "Perl programming, simple input form for the mylibrary database"),
    "\n", h2("Input a new title for the mylibrary database"), "\n";

# process form input (if available)
if(param()) {
  $formTitle   = decode('utf8', param('formTitle'));
  $formAuthors = decode('utf8', param('formAuthors'));

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
    param('formTitle',   '');
    param('formAuthors', '');
  }
}

# show form
print start_form('-accept-charset' => 'utf-8'),
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
print p(), 'Goto ', a({-href=>'mylibrary-find-utf8.pl'}, 'mylibrary-find-utf8'), "\n";

# end
print end_html();
$dbh->disconnect();
