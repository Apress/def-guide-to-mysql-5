#include <stdio.h>
#include <mysql.h>

int main(int argc, char *argv[])
{
  MYSQL *conn;        // connection to MySQL server
  MYSQL_STMT *stmt;   // prepared statement
  MYSQL_BIND bind[3]; // parameters

  char *insert = 
    "INSERT INTO titles (title, subtitle, langID) VALUES (?, ?, ?)";
  char title_buf[256];
  char subtitle_buf[256];
  unsigned long title_len, subtitle_len;
  int langID;
  my_bool langID_is_null;

  // connect to MySQL
  conn = mysql_init(NULL);
  mysql_options(conn, MYSQL_READ_DEFAULT_FILE, "");
  if(mysql_real_connect(
        conn, "localhost", "root", "uranus",
        "mylibrary", 0, NULL, 0) == NULL) {
      fprintf(stderr, "sorry, no database connection ...\n");
      return 1;
    }

  // create statement
  stmt = mysql_stmt_init(conn);

  // prepare statement
  mysql_stmt_prepare(stmt, insert, strlen(insert));

  // define parameters
  memset(bind, 0, sizeof(bind));
  bind[0].buffer_type = FIELD_TYPE_VAR_STRING;
  bind[0].buffer = title_buf;
  bind[0].buffer_length = 256;
  bind[0].length = &title_len;

  bind[1].buffer_type = FIELD_TYPE_VAR_STRING;
  bind[1].buffer = subtitle_buf;
  bind[1].buffer_length = 256;
  bind[1].length = &subtitle_len;

  bind[2].buffer_type = FIELD_TYPE_LONG;
  bind[2].buffer = (gptr) &langID;
  bind[2].is_null = &langID_is_null;
  mysql_stmt_bind_param(stmt, bind);

  // execute 
  strcpy(title_buf, "title1");
  title_len = strlen(title_buf);
  strcpy(subtitle_buf, "test prepared statements");
  subtitle_len = strlen(subtitle_buf);
  langID_is_null = 0;
  langID=1;
  mysql_stmt_execute(stmt);
  printf("new title with titleId=%d has been inserted\n", 
         (int) mysql_insert_id(conn));

  // execute again
  strcpy(title_buf, "title2");
  title_len = strlen(title_buf);
  strcpy(subtitle_buf, "test prepared statements");
  subtitle_len = strlen(subtitle_buf);
  langID_is_null = 1;
  mysql_stmt_execute(stmt);
  printf("new title with titleId=%d has been inserted\n", 
         (int) mysql_insert_id(conn));

  // close statement and connection
  mysql_stmt_close(stmt);
  mysql_close(conn);
  return 0;
}
