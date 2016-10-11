/* SamplePreparedStatement.java */

import java.sql.*;

public class SamplePreparedStatement
{
  public static void main(String[] args)
  {
    try {
      com.mysql.jdbc.jdbc2.optional.MysqlDataSource ds;
      Connection conn;
      PreparedStatement pstmt;

      Class.forName("com.mysql.jdbc.Driver").newInstance();
      conn = DriverManager.getConnection(
        "jdbc:mysql://uranus/mylibrary", "root", "uranus");

      // creates Statement object
      pstmt = conn.prepareStatement("INSERT INTO publishers (publName) VALUES (?)");

      // insert new publisher
      pstmt.setString(1, "O'Reilly3");
      pstmt.executeUpdate();

      // insert new publisher
      pstmt.setString(1, "\\abc\"efg");
      pstmt.executeUpdate();

    }
    catch(Exception e) {
      System.out.println("Error: " + e.toString() );
    }
  }
}

