Dieses Verzeichnis enthält den Code zum SP-Administrator sowie einige
Beispiel-SPs für die Datenbank mylibrary.

Damit der SP-Administrator funktioniert, müssen Sie die Login- und
Passwortzeichenketten in der Datei password.php anpassen! 

sp.sql enthält den Code der Beispiel-SPs aus Kapitel 13. Sie können
wahlweise den SP-Administrator (Restore SPs) oder das folgende
Kommando verwenden, um die SPs in die Datenbank einzufügen:

mysql -u root -p mylibrary --default-character-set=latin1 < sp.sql

