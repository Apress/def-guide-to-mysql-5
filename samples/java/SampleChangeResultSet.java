/* SampleChangeResultSet.java */

import java.sql.*;

public class SampleChangeResultSet
{
  public static void main(String[] args)
  {
    try {
      Connection conn;
      Statement stmt;
      ResultSet res;

      // connect
      Class.forName("com.mysql.jdbc.Driver").newInstance();
      conn = DriverManager.getConnection(
        "jdbc:mysql://uranus/mylibrary", "root", "uranus");
      stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, 
                                  ResultSet.CONCUR_UPDATABLE);
      // insert new publisher, show all
      res = stmt.executeQuery(
        "SELECT publID, publName FROM publishers ORDER BY publID");
      res.moveToInsertRow(); 
      res.updateString(2, "New publisher"); 
      res.insertRow();
      res.last();
      int newid = res.getInt(1);
      res.beforeFirst();
      while (res.next())
        System.out.println(res.getString(1) + " " + res.getString(2));
      res.close();

      // read new publisher
      res = stmt.executeQuery(
        "SELECT publID, publName FROM publishers WHERE publID = " + newid);
      res.next();
      res.updateString(2, "new with another name");
      res.updateRow();

      // delete the new publisher
      res.last();
      res.deleteRow();
      res.close();
    }
    catch(Exception e) {
      System.out.println("Error: " + e.toString() );
    }
  }
}

