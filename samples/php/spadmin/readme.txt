Dieses Verzeichnis enth�lt den Code zum SP-Administrator sowie einige
Beispiel-SPs f�r die Datenbank mylibrary.

Damit der SP-Administrator funktioniert, m�ssen Sie die Login- und
Passwortzeichenketten in der Datei password.php anpassen! 

sp.sql enth�lt den Code der Beispiel-SPs aus Kapitel 13. Sie k�nnen
wahlweise den SP-Administrator (Restore SPs) oder das folgende
Kommando verwenden, um die SPs in die Datenbank einzuf�gen:

mysql -u root -p mylibrary --default-character-set=latin1 < sp.sql

