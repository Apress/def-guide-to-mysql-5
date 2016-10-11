/* HelloMySQL.java */

import java.sql.*;

public class HelloMySQL
{
  public static void main(String[] args)
  {
    try {
      Driver d = (Driver)
        Class.forName("com.mysql.jdbc.Driver").newInstance();
      System.out.println("OK");
    }
    catch(Exception e) {
      System.out.println("Error: " + e.toString() );
    }
  }
}

