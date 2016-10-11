Damit die Beispiele funktionieren, m�ssen Sie die Login- und
Passwortzeichenketten anpassen!

Wenn Sie Red Hat Enterprise Linux 4 oder Fedora Core verwenden, m�ssen
Sie au�erdem in den CGI-Scripts statt localhost den tats�chlichen
Netzwerknamen angeben. Der Grund: Die SELinux-Defaulkonfiguration
verhindert, dass Apache und damit auch Perl-CGI-Scripts auf die
MySQL-Socket-Datei zugreifen darf. Daher muss die Kommunikation �ber
TCP/IP erfolgen!  (Sie k�nnen nat�rlich auch mit
system-config-security SELinux f�r httpd deaktivieren.)

--------

To make the samples work, you MUST change the login and password
strings!

If you use Red Hat Enterprise Linux 4 or Fedora Core, you must also
replace localhost by the real network name. The reason: The SELinux
default configuration does not allow Apache (and Perl CGI scripts
executed by Apache) to access the MySQL socket file. Thus, the
communication with the MySQL server must use TCP/IP. (An other option
is to deactivate the SELinux for httpd using system-config-security.)
