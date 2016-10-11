#!/usr/bin/perl -w
# mylibrary-find.pl

use strict;
use DBI;
use CGI qw(:standard);
use CGI::Carp qw(fatalsToBrowser);

# variables
my($datasource, $user, $passw, $dbh, $search, $sql, $sth, 
   $result, $rows, $i, $row);

# connect to the database
$datasource   = "DBI:mysql:database=mylibrary;host=localhost;";
$user  = "root";
$passw = "uranus";
$dbh = DBI->connect($datasource, $user, $passw,
  {'PrintError' => 0});

# show error message
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
print header(-type => "text/html",  -charset => "latin-1"),
    start_html("Perl programming, search form for the mylibrary database"), "\n",
    h2("Search for titles in the mylibrary database"), "\n";

# process form input (if available)
$search = param('formSearch');
# remove _ and %
$search =~ tr/%_//d;
if($search) {
  print p(), b("Titles beginning with ", escapeHTML($search)), hr();

  # search for all titles
  $sql = "SELECT titles.titleID, title, year, publName, " .
         "       GROUP_CONCAT(authname ORDER BY authname SEPARATOR ', ') " .
         "         AS authors " .
         "FROM titles, authors, rel_title_author " .
         "  LEFT JOIN publishers ON titles.publID = publishers.publID " .
         "WHERE titles.titleID = rel_title_author.titleID " .
         "  AND authors.authID = rel_title_author.authID " .
         "  AND title LIKE '$search%' " .
         "GROUP BY titles.titleID " .
         "ORDER BY title " .
         "LIMIT 100";
  $sth = $dbh->prepare($sql);
  $sth->execute();
  $result = $sth->fetchall_arrayref({});
  $sth->finish();

  # are there any results?
  $rows = @{$result};
  if($rows==0) {
    print p(), "Sorry, no titles found."; }
  # show results
  else {
    # loop through all lines
    for($i=0; $i<$rows; $i++) {
      # collect authors for identical titleID
      $row = $result->[$i];
      print p(), 
	b(escapeHTML($row->{'title'})), ": ",
        i(escapeHTML($row->{'authors'})), ". ",
          escapeHTML($row->{'publName'}), " ",
        $row->{'year'}, "\n";
    }
    print p(), hr(), p(), "New search:", p();
  }
}

# show form
print start_form(),
    p(), "Search for title beginning with ... ",
    textfield({-name => 'formSearch', -size => 20,
               -maxlength => 20}), " ",
    submit({-name => 'formSubmit', -value => 'OK'}),
    end_form();

# show link to mylibrary-simpleinput.pl
print p(), 'Goto ',
      a({-href=>'mylibrary-simpleinput.pl'}, 'mylibrary-simpleinput'),
      "\n";

# end
print end_html();

# end
$dbh->disconnect();
