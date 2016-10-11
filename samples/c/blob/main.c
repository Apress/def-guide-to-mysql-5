#include <stdio.h>
#include <my_global.h>  // for strmov
#include <m_string.h>   // for strmov
#include <mysql.h>

int main(int argc, char *argv[])
{
  int id;
  FILE *f;
  MYSQL *conn;        // connection to MySQL server
  MYSQL_RES *result;  // result of SELECT query
  MYSQL_ROW row;      // one record (row) of SELECT query
  size_t fsize;
  char fbuffer[512 * 1024];  // file size max. 512 kB
  char tmp[1024 * 1024], *tmppos;
  unsigned long *lengths;

  // connect to MySQL
  conn = mysql_init(NULL);
  if(mysql_real_connect(
        conn, "localhost", "root", "uranus", 
        "exceptions", 0, NULL, 0) == NULL) {
      fprintf(stderr, "sorry, no database connection ...\n");
      return 1;
    }

  // read file test.jpg and save it in a new record in table test_blob
  f = fopen("test.jpg", "r");
  fsize = fread(fbuffer, 1, sizeof(fbuffer), f);
  fclose(f);
  tmppos = strmov(tmp, "INSERT INTO test_blob (a_blob) VALUES ('");
  tmppos += mysql_real_escape_string(
    conn, tmppos, fbuffer, fsize);
  tmppos = strmov(tmppos, "')");
  *tmppos++ = (char)0;
  mysql_query(conn, tmp);
  id = (int)mysql_insert_id(conn);

  // read recordset and save data in new file test-copy.jpg
  f = fopen("test-copy.jpg", "w");
  sprintf(tmp, "SELECT a_blob FROM test_blob WHERE id = %i", id);
  mysql_query(conn, tmp);
  result = mysql_store_result(conn);
  row = mysql_fetch_row(result);
  lengths = mysql_fetch_lengths(result);
  fwrite(row[0], 1, lengths[0], f);
  fclose(f);

  // delete new record
  sprintf(tmp, "DELETE FROM test_blob WHERE id = %i", id);
  mysql_query(conn, tmp);

  // free resources
  mysql_free_result(result);
  mysql_close(conn);
  return 0;
}
