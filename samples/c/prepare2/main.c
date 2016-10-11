#include <stdio.h>
#include <mysql.h>

int main(int argc, char *argv[])
{
  MYSQL      *conn;      // connection to MySQL server
  MYSQL_STMT *stmt;      // prepared statement
  char       *cmd = 
    "SELECT title, titleID, catID, ts \
     FROM titles ORDER BY RAND() LIMIT 5";

  MYSQL_BIND    bind[4]; // result columns
  char          title_buf[256];
  unsigned long title_len;
  int           titleID, catID;
  my_bool       catID_is_null;
  MYSQL_TIME    ts;

  int           err;     // return value of mysql functions

  // connect to MySQL
  conn = mysql_init(NULL);
  mysql_options(conn, MYSQL_READ_DEFAULT_FILE, "");
  if(mysql_real_connect(
        conn, "localhost", "root", "uranus",
        "mylibrary", 0, NULL, 0) == NULL) {
      fprintf(stderr, "sorry, no database connection ...\n");
      return 1;
    }

  // only if utf8 output is needed
  mysql_query(conn, "SET NAMES 'utf8'");

  // create statement
  stmt = mysql_stmt_init(conn);

  // prepare statement
  mysql_stmt_prepare(stmt, cmd, strlen(cmd));

  // define result columns
  memset(bind, 0, sizeof(bind));
  bind[0].buffer_type = FIELD_TYPE_VAR_STRING; // title
  bind[0].buffer = title_buf;
  bind[0].buffer_length = 256;
  bind[0].length = &title_len;

  bind[1].buffer_type = FIELD_TYPE_LONG;      // titleID
  bind[1].buffer =  (gptr) &titleID;

  bind[2].buffer_type = FIELD_TYPE_LONG;      // catID
  bind[2].buffer =  (gptr) &catID;
  bind[2].is_null = &catID_is_null;

  bind[3].buffer_type = FIELD_TYPE_TIMESTAMP; // ts
  bind[3].buffer = (gptr) &ts;

  // bind columns to result
  mysql_stmt_bind_result(stmt, bind);

  // execute statement
  err = mysql_stmt_execute(stmt);
  if(err) {
    fprintf(stderr, "sorry, an error happened ...\n");
    return 1;  }

  // get all results
  mysql_stmt_store_result(stmt);

  // loop through all results
  while(!mysql_stmt_fetch(stmt)) {

    printf("titleID=%d \t", titleID);

    if(catID_is_null)
      printf("catID=NULL \t");
    else
      printf("catID=%d \t", catID);
    printf("timestamp=%d-%02d-%02d %02d-%02d-%02d\t", 
	   ts.year, ts.month, ts.day, 
	   ts.hour, ts.minute, ts.second);
    printf("title=%s\n", title_buf);
  }

  // close statement and connection
  mysql_stmt_close(stmt);
  mysql_close(conn);
  return 0;
}
