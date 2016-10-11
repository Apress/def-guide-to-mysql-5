/* SampleGetID3.java */

import java.sql.*;

public class SampleGetID3
{
  public static void main(String[] args)
  {
    try {
      long id;
      Connection conn;
      Statement stmt;
      ResultSet newid;

      // connect to MySQL
      Class.forName("com.mysql.jdbc.Driver").newInstance();
      conn = DriverManager.getConnection(
        "jdbc:mysql://uranus/mylibrary", "root", "uranus");
      conn.setAutoCommit(false);

      // process one INSERT query
      stmt = conn.createStatement();
      stmt.executeUpdate(
        "INSERT INTO publishers (publName) VALUES ('new publisher')");
      newid = stmt.executeQuery("SELECT LAST_INSERT_ID()");
      if(newid.next()) {
        id = newid.getInt(1);
        System.out.println("new ID = " + id); }
      conn.commit();
    }
    catch(Exception e) {
      System.out.println("Error: " + e.toString() );
    }
  }
}
