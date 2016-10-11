/* SampleGetID1.java 
   works ONLY with Java 2 version >= 1.4! */

import java.sql.*;

public class SampleGetID1
{
  public static void main(String[] args)
  {
    try {
      int id, n;
      Connection conn;
      Statement stmt;
      ResultSet newid, newids;

      // connect to MySQL
      Class.forName("com.mysql.jdbc.Driver").newInstance();
      conn = DriverManager.getConnection(
        "jdbc:mysql://uranus/mylibrary", "root", "uranus");

      // process one INSERT query
      stmt = conn.createStatement();
      n = stmt.executeUpdate(
        "INSERT INTO publishers (publName) VALUES ('new publisher')");
      newid = stmt.getGeneratedKeys();
      newid.next();
      id = newid.getInt(1);
      System.out.println("number of new records = " + n);
      System.out.println("ID = " + id);
      System.out.println();

      // process three INSERT queries together
      n = stmt.executeUpdate(
        "INSERT INTO publishers (publName) VALUES ('publ1'), ('publ2'), ('publ3')", 
        Statement.RETURN_GENERATED_KEYS);
      System.out.println("number of new records = " + n);
      newids = stmt.getGeneratedKeys();
      while(newids.next()) {  // only gives ID for 
        System.out.println("ID = " + newids.getInt(1));
      }

    }
    catch(Exception e) {
      System.out.println("Error: " + e.toString() );
    }
  }
}
