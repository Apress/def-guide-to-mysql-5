#!/usr/bin/perl
# Testdatei cgi-test.pl
use CGI qw(:standard);
use CGI::Carp qw(fatalsToBrowser);
print header(),
    start_html("Hello CGI"), 
    p("Hello CGI"), 
    end_html();
