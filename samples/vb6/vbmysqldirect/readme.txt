To make this example work, install VBMySQLDirect from
http://www.vbmysql.com/projects/vbmysqldirect/ first!

Also, the table mylibrary.titles needs one additional column:

USE mylibrary
ALTER TABLE titles ADD authors VARCHAR(255)


