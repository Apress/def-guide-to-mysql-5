Diese Datenbanken gehören zum Buch

  Michael Kofler: MySQL, 3. Auflage
  deutsche Ausgabe: Addison-Wesley Germany, 2005

Die *.sql-Dateien enthalten Beispieldatenbanken.  Um eine Datenbank zu
importieren, führen Sie die zwei folgenden Kommandos aus und ersetzen
dabei mylibrary durch den Namen der Datenbank

  > mysqladmin -u root -p create mylibrary
  Enter password: xxxxx
  > mysql -u root -p mylibrary < mylibrary.sql
  Enter password: xxxxx

test_vote.sql      Kapitel 3
exceptions.sql     Kapitel 8-10
mylibrary.sql      Kapitel 8-10, 15-20
mylibraryutf8.sql  (Unicode-Version von mylibrary.sql)
myforum.sql        Kapitel 8
bigvote.sql        Kapitel 10 (große Version von test_vote.sql)
glacier.sql        Kapitel 12
opengeodb.sql      Kapitel 12

Die import*.txt-Dateien dienen zum Test verschiedener import-Kommandos
(siehe Kapitel 14)


----------------

Theses databases are part of the book

  Michael Kofler: MySQL, 3rd edition
  english edition: apress, 2005

The *.sql files contain the sample databases. To import a database,
use the two following commands (replace mylibrary by the name of the
database):

  > mysqladmin -u root -p create mylibrary
  Enter password: xxxxx
  > mysql -u root -p mylibrary < mylibrary.sql
  Enter password: xxxxx

test_vote.sql      chapter 3
exceptions.sql     chapter 8-10
mylibrary.sql      chapter 8-10, 15-20
mylibraryutf8.sql  (unicode version of mylibrary.sql)
myforum.sql        chapter 8
bigvote.sql        chapter 10 (bigger version of test_vote.sql)
glacier.sql        chapter 12
opengeodb.sql      chapter 12

The import*.txt files allow you to test various text import commands (see
chapter 14)

---------------

(c) 2005 Michael Kofler
