Dieses Beispiel geht davon aus, dass die Datenbank testimages mit der Tabelle images existiert.

This example assumes that the database test_images with the table images exists.

CREATE DATABASE testimages;

USE testimages;

CREATE TABLE images (
  id    BIGINT NOT NULL AUTO_INCREMENT,
  name  VARCHAR(100) NOT NULL,
  type  VARCHAR(100) NOT NULL,
  image LONGBLOB NOT NULL,
  ts    TIMESTAMP(14) NOT NULL,
  PRIMARY KEY  (id));
