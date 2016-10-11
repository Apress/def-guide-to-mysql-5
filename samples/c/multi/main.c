#include <stdio.h>
#include <mysql.h>

int main(int argc, char *argv[])
{
  int        i, next;
  MYSQL     *conn;    // connection to MySQL server
  MYSQL_RES *result;  // result of SELECT query
  MYSQL_ROW row;      // one record (row) of SELECT query

  // connect to MySQL
  conn = mysql_init(NULL);
  mysql_options(conn, MYSQL_READ_DEFAULT_GROUP, "");
  if(mysql_real_connect(
        conn, "localhost", "root", "uranus", 
        "mylibrary", 0, NULL, 0) == NULL) {
      fprintf(stderr, "sorry, no database connection ...\n");
      return 1;
    }
  mysql_set_server_option(conn, MYSQL_OPTION_MULTI_STATEMENTS_ON);

  // only if utf8 output is needed
  mysql_query(conn, "SET NAMES 'utf8'");

  // execute several SQL commands
  const char *sql="SELECT * FROM categories LIMIT 5;\
                   INSERT INTO categories (catName) VALUES ('test1'), ('test2');\
                   SELECT 1+2;\
                   DELETE FROM categories WHERE catName LIKE 'test%';\
                   DROP TABLE IF EXISTS dummy";
  if(mysql_query(conn, sql)) {
    fprintf(stderr, "MySQL error: %s\n", mysql_error(conn));
    fprintf(stderr, "MySQL error number: %i\n", mysql_errno(conn));
  }

  do  // loop through all results (while(!mysql_next_result)
  {
    printf("\n-----------------------------------------------\n\n");
    printf("Affected rows: %i\n", mysql_affected_rows(conn));
    if(mysql_warning_count(conn))
      fprintf(stderr, "MySQL warnings: %i\n", mysql_warning_count(conn));

    result= mysql_store_result(conn); 
    if(result) {
      // loop through all found rows
      while((row = mysql_fetch_row(result)) != NULL) {
        printf("result: ");
        for(i=0; i < mysql_num_fields(result); i++) {
          if(row[i] == NULL)
            printf("[NULL]\t");
          else
            printf("%s\t", row[i]);
        }
        printf("\n");
      }
      mysql_free_result(result);
    } else
      printf("no result\n");

    next = mysql_next_result(conn);
    if(next>0) {
      printf("\n-----------------------------------------------\n\n");
      printf("mysql_next_result error code: %i\n", next);
      if(mysql_errno(conn))
	fprintf(stderr, "MySQL error: %s\n", mysql_error(conn));
    }
  } while (!next);

  // de-allocate memory of result, close connection
  mysql_close(conn);
  return 0;
}

