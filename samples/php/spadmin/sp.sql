DELIMITER $$
DROP PROCEDURE IF EXISTS mylibrary.categories_insert$$
CREATE PROCEDURE `mylibrary`.`categories_insert`(IN newcatname VARCHAR(60), IN parent INT, OUT newid INT)
proc: BEGIN
  DECLARE cnt INT;
  SET newid=-1;

  -- basic validation
  SELECT COUNT(*) FROM categories 
  WHERE parentCatID=parent INTO cnt;
  IF ISNULL(newcatname) OR TRIM(newcatname)="" OR cnt=0 THEN
    LEAVE proc;
  END IF;

  -- test if category already exists
  SELECT COUNT(*) FROM categories 
  WHERE parentCatID=parent AND catName=newcatname 
  INTO cnt;
  IF cnt=1 THEN 
    SELECT catID FROM categories 
    WHERE parentCatID=parent AND catName=newcatname 
    INTO newid;
    LEAVE proc; 
  END IF;

  -- actually insert new category
  INSERT INTO categories (catName, parentCatID)
  VALUES (newcatname, parent);
  SET newid = LAST_INSERT_ID();
END proc$$
DROP PROCEDURE IF EXISTS mylibrary.cursortest$$
CREATE PROCEDURE `mylibrary`.`cursortest`(OUT avg_len DOUBLE)
BEGIN
  DECLARE t, subt VARCHAR(100);
  DECLARE done INT DEFAULT 0;
  DECLARE n BIGINT DEFAULT 0;
  DECLARE cnt INT;

  DECLARE mycursor CURSOR FOR 
    SELECT title, subtitle FROM titles;

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;

  SELECT COUNT(*) FROM titles INTO cnt;
  OPEN mycursor;
  myloop: LOOP
    FETCH mycursor INTO t, subt;
    IF done=1 THEN LEAVE myloop; END IF;
    SET n = n + CHAR_LENGTH(t);
    IF NOT ISNULL(subt) THEN
      SET n = n + CHAR_LENGTH(subt);
    END IF;
  END LOOP myloop;
  SET avg_len = n/cnt;
END$$
DROP FUNCTION IF EXISTS mylibrary.faculty$$
CREATE FUNCTION `mylibrary`.`faculty`(n BIGINT) RETURNS BIGINT
BEGIN
  IF n>=2 THEN
    RETURN n * faculty(n-1);
  ELSE
    RETURN n;
  END IF;
END$$
DROP PROCEDURE IF EXISTS mylibrary.find_subcategories$$
CREATE PROCEDURE `mylibrary`.`find_subcategories`(IN id INT, IN cname VARCHAR(60), IN catlevel INT, INOUT catrank INT)
BEGIN
  DECLARE done INT DEFAULT 0;
  DECLARE subcats CURSOR FOR 
    SELECT catID, catName FROM categories WHERE parentCatID=id
    ORDER BY catname;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;

  OPEN subcats;
  subcatloop: LOOP
    FETCH subcats INTO id, cname;
    IF done=1 THEN LEAVE subcatloop; END IF;
    SET catrank = catrank+1;
    INSERT INTO __subcats VALUES (catrank, catlevel, id, cname);
    CALL find_subcategories(id, cname, catlevel+1, catrank);
  END LOOP subcatloop;
  CLOSE subcats;
END$$
DROP PROCEDURE IF EXISTS mylibrary.get_parent_categories$$
CREATE PROCEDURE `mylibrary`.`get_parent_categories`(startid INT)
BEGIN
  DECLARE i, id, pid, cnt INT DEFAULT 0;
  DECLARE cname VARCHAR(60);

  DROP TABLE IF EXISTS __parent_cats;
  CREATE TEMPORARY TABLE __parent_cats 
    (level INT, catID INT, catname VARCHAR(60)) ENGINE = HEAP;

  main: BEGIN 
    -- test if startid is OK
    SELECT COUNT(*) FROM categories WHERE catID=startID INTO cnt;
    IF cnt=0 THEN LEAVE main; END IF;

    -- insert start category into new table
    SELECT catID, parentCatID, catName 
    FROM categories WHERE catID=startID 
    INTO id, pid, cname;
    INSERT INTO __parent_cats VALUES(i, id, cname);

    -- loop until root of categories is reached
    parentloop: WHILE NOT ISNULL(pid) DO
      SET i=i+1;
      SELECT catID, parentCatID, catName 
      FROM categories WHERE catID=pid 
      INTO id, pid, cname;
      INSERT INTO __parent_cats VALUES(i, id, cname);
    END WHILE parentloop;
  END main;

  SELECT catID, catname FROM __parent_cats ORDER BY level DESC;
  DROP TABLE __parent_cats;
END$$
DROP PROCEDURE IF EXISTS mylibrary.get_subcategories$$
CREATE PROCEDURE `mylibrary`.`get_subcategories`(IN startid INT, OUT n INT)
BEGIN
  DECLARE cnt INT;
  DECLARE cname VARCHAR(60);
  DROP TABLE IF EXISTS __subcats;
  CREATE TEMPORARY TABLE __subcats
    (rank INT, level INT, catID INT, catname VARCHAR(60)) ENGINE = HEAP;
  SELECT COUNT(*) FROM categories WHERE catID=startID INTO cnt;
  IF cnt=1 THEN 
    SELECT catname FROM categories WHERE catID=startID INTO cname;
    INSERT INTO __subcats VALUES(0, 0, startid, cname);
    CALL find_subcategories(startid, cname, 1, 0);
  END IF;
  SELECT COUNT(*) FROM __subcats INTO n;
END$$
DROP PROCEDURE IF EXISTS mylibrary.get_title$$
CREATE PROCEDURE `mylibrary`.`get_title`(IN id INT)
BEGIN
  SELECT title, subtitle, publName 
  FROM titles, publishers 
  WHERE titleID=id 
  AND titles.publID = publishers.publID;
END$$
DROP FUNCTION IF EXISTS mylibrary.shorten$$
CREATE FUNCTION `mylibrary`.`shorten`(s VARCHAR(255), n INT) RETURNS VARCHAR(255)
BEGIN
  IF ISNULL(s) THEN
    RETURN '';
  ELSEIF n<15 THEN
    RETURN LEFT(s, n);
  ELSE
    IF CHAR_LENGTH(s) <= n THEN
      RETURN s;
    ELSE
      RETURN CONCAT(LEFT(s, n-10), ' ... ', RIGHT(s, 5));
    END IF;
  END IF;
  
END$$
DROP FUNCTION IF EXISTS mylibrary.swap_name$$
CREATE FUNCTION `mylibrary`.`swap_name`(s VARCHAR(100)) RETURNS VARCHAR(100)
BEGIN
  DECLARE pos, clen INT;
  SET s = TRIM(s);
  SET clen = CHAR_LENGTH(s);
  SET pos =  LOCATE(" ", REVERSE(s));
  IF pos = 0 THEN RETURN s; END IF;
  SET pos = clen-pos;
  RETURN CONCAT(SUBSTR(s, pos+2), " ", LEFT(s, pos));
END$$
DROP PROCEDURE IF EXISTS mylibrary.titles_insert_all$$
CREATE PROCEDURE `mylibrary`.`titles_insert_all`(IN newtitle VARCHAR(100), IN publ VARCHAR(60), IN authList VARCHAR(255), OUT newID INT)
proc: BEGIN
  DECLARE cnt, pos INT;
  DECLARE aID, pblID, ttlID INT;
  DECLARE author VARCHAR(60);
  SET newID=-1;

  -- publisher
  SELECT COUNT(*) FROM publishers WHERE publname=publ INTO cnt;
  IF cnt=1 THEN
    SELECT publID FROM publishers WHERE publname=publ INTO pblID;
  ELSE
    INSERT INTO publishers (publName) VALUES (publ);
    SET pblID = LAST_INSERT_ID();
  END IF;

  -- insert title
  INSERT INTO titles (title, publID) VALUES (newtitle, pblID);
  SET ttlID = LAST_INSERT_ID();

  -- loop through all authors
  authloop: WHILE NOT (authList="") DO
    SET pos = LOCATE(";", authList);
    IF pos=0 THEN
      SET author = TRIM(authList);
      SET authList ="";
    ELSE
      SET author = TRIM(LEFT(authList, pos-1));
      SET authList = SUBSTR(authList, pos+1);
    END IF;
    IF author = "" THEN ITERATE authloop; END IF;

    -- find author or insert into authors table
    SELECT COUNT(*) FROM authors 
    WHERE authName=author OR authName=swap_name(author)
    INTO cnt;
    IF cnt>=1 THEN
      SELECT authID FROM authors 
      WHERE authName=author OR authName=swap_name(author)
      LIMIT 1 INTO aID;
    ELSE
      INSERT INTO authors (authName) VALUES (author);
      SET aID = LAST_INSERT_ID();
    END IF;

    -- update rel_title_authors
    INSERT INTO rel_title_author (titleID, authID)
    VALUES (ttlID, aID);
  END WHILE authloop;

  -- return value
  SET newID=ttlID;  
END proc$$
DELIMITER ;
