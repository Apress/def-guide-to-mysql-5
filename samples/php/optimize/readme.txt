Die drei PHP-Dateien demonstrieren Möglichkeiten zur
Geschwindigkeitsoptimierung von PHP-Code.  Die Beispiele gehen davon
aus, dass die Datenbank mylibrary funktioniert. (Die Zugangsdaten
werden aus ../password.php gelesen.)

- create_categories_test.php erstellt ein Backup der
  categories-Tabelle und erzeugt dann eine neue categories-Tabelle mit
  zufälligen Beispieldaten.

- show_categories_list.php erzeugt aus der categories-Tabelle auf drei
  unterschiedliche Arten eine Auswahlliste. Die drei Varianten
  unterscheiden sich durch ihre Effizienz.

- remove_categories_test.php löscht die categories-Testtabelle 
  und stellt die ursprüngliche categories-Tabelle wieder her.
