#!/usr/bin/perl -w
# cgi-test-mysql.pl

use strict;
use DBI;
use CGI qw(:standard);
use CGI::Carp qw(fatalsToBrowser);
use HTML::Entities;

# variables
my($dbh, $sth, $row, @ary);

# show header
print header(),
    start_html("Hello CGI"), "\n",
    h1("Helle CGI"), "\n";

# connect
$dbh = DBI->connect(
  "DBI:mysql:database=mysql;host=localhost",
  "root", "xxx", {'RaiseError' => 1});

if(DBI->err()) {
  print p("Sorry, no database connection"), end_html(); 
  exit();
}

# do query
$sth = $dbh->prepare("SHOW DATABASES");
$sth->execute();

# show results
while(@ary = $sth->fetchrow_array()) {
  print br(), join(" ", @ary);
}
$sth->finish();

print end_html();

# end
$dbh->disconnect();
