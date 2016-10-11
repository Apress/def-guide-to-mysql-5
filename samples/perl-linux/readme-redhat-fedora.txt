Damit die Beispiele funktionieren, müssen Sie die Login- und
Passwortzeichenketten anpassen!

Wenn Sie Red Hat Enterprise Linux 4 oder Fedora Core verwenden, müssen
Sie außerdem in den CGI-Scripts statt localhost den tatsächlichen
Netzwerknamen angeben. Der Grund: Die SELinux-Defaulkonfiguration
verhindert, dass Apache und damit auch Perl-CGI-Scripts auf die
MySQL-Socket-Datei zugreifen darf. Daher muss die Kommunikation über
TCP/IP erfolgen!  (Sie können natürlich auch mit
system-config-security SELinux für httpd deaktivieren.)

--------

To make the samples work, you MUST change the login and password
strings!

If you use Red Hat Enterprise Linux 4 or Fedora Core, you must also
replace localhost by the real network name. The reason: The SELinux
default configuration does not allow Apache (and Perl CGI scripts
executed by Apache) to access the MySQL socket file. Thus, the
communication with the MySQL server must use TCP/IP. (An other option
is to deactivate the SELinux for httpd using system-config-security.)
