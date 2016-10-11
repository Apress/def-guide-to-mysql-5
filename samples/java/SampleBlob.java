/* SampleBlob.java */

import java.sql.*;
import java.io.*;

public class SampleBlob
{
  public static void main(String[] args)
  {
    try {
      // loads Connector/J driver
      Class.forName("com.mysql.jdbc.Driver").newInstance();

      // connects to MySQL
      Connection conn = DriverManager.getConnection(
        "jdbc:mysql://uranus/exceptions", "root", "uranus");

      // creates Statement objects
      PreparedStatement pstmt1, pstmt2, pstmt3;
      pstmt1 = conn.prepareStatement(
        "INSERT INTO test_blob (a_blob) VALUES(?)");
      pstmt2 = conn.prepareStatement(
        "SELECT a_blob FROM test_blob WHERE id=?");
      pstmt3 = conn.prepareStatement(
        "DELETE FROM test_blob WHERE id=?");

      // read file and insert into a BLOB
      File readfile = new File("test.jpg");
      FileInputStream fis = new FileInputStream(readfile);
      pstmt1.setBinaryStream(1, fis, (int)readfile.length());
      pstmt1.executeUpdate();
      fis.close();

      // id of new record in table a_blob
      long id = ((com.mysql.jdbc.Statement)pstmt1).getLastInsertID();

      // create new empty file
      File writefile = new File("copy-test.jpg");
      if(writefile.exists()) {
        writefile.delete();
        writefile.createNewFile(); }
      FileOutputStream fos = new FileOutputStream(writefile);

      // retrieve BLOB from a_blob table
      pstmt2.setLong(1, id);
      ResultSet res = pstmt2.executeQuery();
      res.next();
      InputStream is = res.getBinaryStream(1);

      // save BLOB into new file
      final int BSIZE = 2^15;
      int n;
      byte[] buffer = new byte[BSIZE];
      while((n=is.read(buffer, 0, BSIZE))>0)
        fos.write(buffer, 0, n);
      
      // close open objects
      is.close();
      fos.close();
      res.close();

      // delete new recordset 
      pstmt3.setLong(1, id);
      pstmt3.executeUpdate();
    }
    catch(Exception e) {
      System.out.println("Error: " + e.toString() );
    }
  }
}

