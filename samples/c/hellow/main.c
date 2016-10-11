#include <stdio.h>
#include <mysql.h>

int main(int argc, char *argv[])
{
  int i;
  MYSQL *conn;        // connection to MySQL server
  MYSQL_RES *result;  // result of SELECT query
  MYSQL_ROW row;      // one record (row) of SELECT query

  // connect to MySQL
  conn = mysql_init(NULL);
  // mysql_options(conn, MYSQL_READ_DEFAULT_GROUP, "myclient");
  if(mysql_real_connect(
        conn, "localhost", "root", "uranus", 
        "mylibrary", 0, NULL, 0) == NULL) {
      fprintf(stderr, "sorry, no database connection ...\n");
      return 1;
    }

  // only if utf8 output is needed
  mysql_query(conn, "SET NAMES 'utf8'");

  // retrieve list of all publishers in mylibrary
  const char *sql="SELECT COUNT(titleID), publName \
                   FROM publishers, titles \
                   WHERE publishers.publID = titles.publID  \
                   GROUP BY publishers.publID \
                   ORDER BY publName";
  if(mysql_query(conn, sql)) {
    fprintf(stderr, "%s\n", mysql_error(conn));
    fprintf(stderr, "Fehlernummer %i\n", mysql_errno(conn));
    fprintf(stderr, "%s\n", sql);
    return 1;
  }

  // process results
  result = mysql_store_result(conn);
  if(result==NULL) {
    if(mysql_error(conn))
      fprintf(stderr, "%s\n", mysql_error(conn));
    else
      fprintf(stderr, "%s\n", "unknown error\n");
    return 1;
  }
  printf("%i records found\n", (int)mysql_num_rows(result));

  // loop through all found rows
  while((row = mysql_fetch_row(result)) != NULL) {
    for(i=0; i < mysql_num_fields(result); i++) {
      if(row[i] == NULL)
        printf("[NULL]\t");
      else
        printf("%s\t", row[i]);
    }
    printf("\n");
  }

  // de-allocate memory of result, close connection
  mysql_free_result(result);
  mysql_close(conn);
  return 0;
}

// // copy configuration options into argc/argv
// const char *groups[] = {"client", NULL};
// load_defaults("my", groups, &argc, &argv);

// // test some info functions
// printf("%s\n", mysql_get_host_info(conn));
// printf("%s\n", mysql_get_client_info());
// printf("%s\n", mysql_get_server_info(conn));
// printf("%i\n", mysql_get_proto_info(conn));

// // insert publisher with special characters
// #include <my_global.h>  // for strmov
// #include <m_string.h>   // for strmov
// char tmp[1000], *tmppos;
// char *publname = "O'Reilly";
// tmppos = strmov(tmp, "INSERT INTO publishers (publName) VALUES ('");
// tmppos += mysql_real_escape_string(
//   conn, tmppos, publname, strlen(publname));
// tmppos = strmov(tmppos, "')");
// *tmppos++ = (char)0;
// mysql_query(conn, tmp);
