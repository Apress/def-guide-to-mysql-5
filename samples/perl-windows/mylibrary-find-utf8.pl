#!/usr/bin/perl -w
# mylibrary-find-utf8.pl

use strict;
use DBI;
use CGI qw(:standard);
use CGI::Carp qw(fatalsToBrowser);
# use utf8;  # not needed in this script
use Encode qw(decode);
binmode(STDOUT, ":utf8");

# variables
my($datasource, $user, $passw, $dbh, $search, $sql, $sth,
   $result, $rows, $i, $row, $authors);

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

# tell MySQL we communicate using utf8
$dbh->do("SET NAMES 'utf8'");

# print HTML header
print header(-type => "text/html",  -charset => "utf-8"),
    start_html(-encoding => 'utf-8',
      "Perl programming, search form for the mylibrary database"), "\n",
    h2("Search for titles in the mylibrary database"), "\n";

# process form input (if available), decode from utf8
$search = decode('utf8', param('formSearch'));
# remove _ and %
$search =~ tr/%_//d;
if($search) {
  print p(), b("Titles beginning with ", escapeHTML($search)), hr();

  # search for all titles
  $sql = "SELECT titles.titleID, titles.title, titles.year, " .
         "       publishers.publName, authors.authName " .
         "FROM titles, authors, rel_title_author " .
         "  LEFT JOIN publishers ON titles.publID = publishers.publID " .
         "WHERE titles.titleID = rel_title_author.titleID " .
         "  AND authors.authID = rel_title_author.authID " .
         "  AND title LIKE '$search%' " .
         "ORDER BY title, titleID, authName " .
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
      if($authors) {$authors .= ", ";}
      $authors .= $row->{'authName'};

      # show title if this is the last recordset or
      # if next recordset has a different titleID

      # encode_entities --> escapeHTML

      if($i==$rows-1 || 
         $row->{'titleID'} != $result->[$i+1]->{'titleID'}) {
        print p(), 
          b(escapeHTML(decode("utf8", $row->{'title'}))), ": ",
          i(escapeHTML(decode("utf8", $authors))), ". ", 
          escapeHTML(decode("utf8", $row->{'publName'})), " ",
          $row->{'year'}, "\n";
        $authors = "";
      }
    }
    print p(), hr(), p(), "New search:", p(), "\n";
  }
}

# show form

param('formSearch', $search);
print start_form('-accept-charset' => 'utf-8'),
    p(), "Search for title beginning with ... ",
    textfield({-name => 'formSearch', 
               -size => 20,
               -maxlength => 20}), " \n",
    submit({-name => 'formSubmit', -value => 'OK'}), "\n",
    end_form(), "\n";

# show link to mylibrary-simpleinput.pl
print p(), 'Goto ', 
      a({-href=>'mylibrary-simpleinput-utf8.pl'}, 'mylibrary-simpleinput-utf8'), 
      "\n";

print end_html();

# end
$dbh->disconnect();
