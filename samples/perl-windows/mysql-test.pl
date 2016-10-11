#!/usr/bin/perl
use DBI();

# connect
$dbh = DBI->connect(
 "DBI:mysql:database=mysql;host=localhost",
 "root", "xxxx", {'RaiseError' => 1});

# do query
$sth = $dbh->prepare("SHOW DATABASES");
$sth->execute();

# show results
while(@ary = $sth->fetchrow_array()) {
  print join("\t", @ary), "\n";
}
$sth->finish();

# wait for return 
print "Please hit Return to end the program!";
$wait_for_return = <STDIN>;
