/* SampleIntro.java */

import java.sql.*;

public class SampleIntro
{
  public static void main(String[] args)
  {
    try {
      Connection conn;
      Statement stmt;
      ResultSet res;

      // loads Connector/J driver
      Class.forName("com.mysql.jdbc.Driver").newInstance();

      // connects to MySQL
      conn = DriverManager.getConnection(
        "jdbc:mysql://uranus/mylibrary", "root", "uranus");

      // creates Statement object
      stmt = conn.createStatement();

      // process SQL SELECT query
      res = stmt.executeQuery(
        "SELECT publID, publName FROM publishers " + 
        "ORDER BY publName");

      // retrieve results
      while (res.next()) {
        int id = res.getInt("publID");
        String name = res.getString("publName");
        System.out.println("ID: " + id + "  Name: " + name);
      }
      res.close();
      
    }
    catch(Exception e) {
      System.out.println("Error: " + e.toString() );
    }
  }
}

