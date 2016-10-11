Die drei PHP-Dateien demonstrieren M�glichkeiten zur
Geschwindigkeitsoptimierung von PHP-Code.  Die Beispiele gehen davon
aus, dass die Datenbank mylibrary funktioniert. (Die Zugangsdaten
werden aus ../password.php gelesen.)

- create_categories_test.php erstellt ein Backup der
  categories-Tabelle und erzeugt dann eine neue categories-Tabelle mit
  zuf�lligen Beispieldaten.

- show_categories_list.php erzeugt aus der categories-Tabelle auf drei
  unterschiedliche Arten eine Auswahlliste. Die drei Varianten
  unterscheiden sich durch ihre Effizienz.

- remove_categories_test.php l�scht die categories-Testtabelle 
  und stellt die urspr�ngliche categories-Tabelle wieder her.
