Diese Beispieldateien demonstrieren verschiedene Programmiertechniken
f�r den Zugriff auf MySQL-Datenbanken. Die meisten Beispiele setzen
zumindest die Versionen PHP >= 5.0.3 (mit mysqli-Schnittstelle) und
MySQL >=4.1 voraus. Die Stored Procedure-Beispiele setzen MySQL >=
5.0.2 voraus.  Einzig mysql-intro.php und phpinfo.php laufen auch mit
�lteren PHP- und MySQL-Versionen.

Damit die Beispiele funktionieren, m�ssen Sie die Login- und
Passwortzeichenketten in den folgenden Dateien anpassen!

Wenn Sie Red Hat Enterprise Linux 4 oder Fedora Core verwenden, m�ssen
Sie au�erdem statt localhost den tats�chlichen Netzwerknamen
angeben. Der Grund: Die SELinux-Defaulkonfiguration verhindert, dass
Apache und damit auch PHP auf die MySQL-Socket-Datei zugreifen
darf. Daher muss die Kommunikation �ber TCP/IP erfolgen! (Sie k�nnen
nat�rlich auch mit system-config-security SELinux f�r httpd
deaktivieren.)

- mysql-intro.php
- mysqli-intro.php
- password.php

�berblick �ber die Beispieldateien

phpinfo.php           	testet, welche Schnittstellen PHP enth�lt
mysql-intro.php       	stellt die mysql-Schnittstelle vor
mysqli-intro.php      	stellt die mysqli-Schnittstelle vor
mysqli-prepared.php   	Beispiel f�r prepared statements
mysqli-table.php      	Formatierung eines SELECT-Ergebnisses als Tabelle

mydb.php              	Definition der Klasse MyDb
test-mydb.php         	Test der Klasse MyDB
password.php          	Passwortdaten f�r MyDb

categories.php        	Kategorieverwaltung f�r mylibrary
find.php              	Titelsuche f�r mylibrary
titleform.php         	Titeleingabe f�r mylibrary

formfunctions.php       Hilfsfunktionen zum Erzeugen von Formularen
mylibraryfunctions.php  Hilfsfunktionen f�r categories.php,
                        find.php und titleform.php

deletegarbage.php       l�scht ung�ltige Eintr�ge aus mylibrary

*.css                   diverse CSS-Dateien

optimize/*              Beispiel zur Effizienzoptimierung
images/*                Beispiel zum Bild-Upload
spadmin/*               SP-Administrator
unicode/*               Unicode-Variante der mylibrary-Beispiele

--------------------------------------------------

These sample files show various programming techniques. Most samples
need PHP >= 5.0.3 with the mysqli interface and MySQL >= 4.1. The samples for stored procedures need MySQL >= 5.0.2.

To make the samples work, you MUST change the login and password
strings in the following files!

If you use Red Hat Enterprise Linux 4 or Fedora Core, you must also
replace localhost by the real network name. The reason: The SELinux
default configuration does not allow Apache (and PHP) to access the
MySQL socket file. Thus, the communication with the MySQL server must
use TCP/IP. (An other option is to deactivate the SELinux for httpd
using system-config-security.)

- mysql-intro.php
- mysqli-intro.php
- password.php

Overview over the sample files

phpinfo.php           	tests which extensions PHP supports
mysql-intro.php       	intro sample for the mysql interface (extension)
mysqli-intro.php      	intro sample for the mysqli interface (extension)
mysqli-prepared.php   	example for prepared statements
mysqli-table.php      	formats a SELECT result as HTML table

mydb.php              	definition of the class MyDb
test-mydb.php         	test of  MyDB
password.php          	password data for MyDb

categories.php        	category management for the mylibrary sample
find.php              	titlesearch for mylibrary
titleform.php         	title input for mylibrary

formfunctions.php       various functions to create HTML forms
mylibraryfunctions.php  various functions for categories.php,
                        find.php und titleform.php

deletegarbage.php       deletes invalid entries from mylibrary

*.css                   various CSS files

optimize/*              sample for code tuning
images/*                sample for image upload
spadmin/*               SP administrator
unicode/*               unicode variant of the mylibrary samples
