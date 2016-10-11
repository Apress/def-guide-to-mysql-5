/* SampleConnection1.java */

import java.sql.*;

public class SampleConnection1
{
  public static void main(String[] args)
  {
    try {
      com.mysql.jdbc.jdbc2.optional.MysqlDataSource ds;
      Connection conn1, conn2;
      Statement stmt;
      ResultSet res;

      System.out.println("connect via DriverManager");      
      Class.forName("com.mysql.jdbc.Driver").newInstance();
      conn1 = DriverManager.getConnection(
        "jdbc:mysql://uranus/mylibrary", "root", "uranus");

      // creates Statement object
      stmt = conn1.createStatement();

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
    }
    catch(Exception e) {
      System.out.println("Error: " + e.toString() );
    }
  }
}

