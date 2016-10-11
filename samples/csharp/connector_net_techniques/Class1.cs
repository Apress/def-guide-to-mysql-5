using System;
using System.Data;
using MySql.Data.MySqlClient;

namespace mysql_connect {
  class mainclass {
    [STAThread]
    static void Main(string[] args) {
      MySQLtest tst = new MySQLtest();
      // tst.tst_dataset();
      // tst.test_scalar();
      // tst.test_param();
      tst.test_last_insert_id();
      tst.test_data_adapter();
      Console.WriteLine("Return drücken");
      Console.ReadLine();
    }
  }

  class MySQLtest {
    MySqlConnection myconn;

    // constructor
    public MySQLtest() {     // use constructor to connect
      myconn = new MySqlConnection(
        "Data Source=192.168.80.128;Initial Catalog=mylibrary;" +
          "User ID=root;PWD=uranus");
      myconn.Open();
    }

    public void test_scalar() {
      MySqlCommand com;
      object obj;
      DateTime dt;
      com = new MySqlCommand("SELECT MAX(ts) FROM authors ", myconn);
      obj = com.ExecuteScalar();
      dt = (DateTime)obj;
      Console.WriteLine(obj.ToString());
    }

    public void test_param() {
      MySqlCommand com2;
      MySqlParameter pname, pid, pts;
      com2 = myconn.CreateCommand();
      com2.CommandText =
        "INSERT INTO authors (authName, authID, ts) VALUES(?name, ?id, ?ts)";
      pname = com2.Parameters.Add("?name", MySqlDbType.VarChar);
      pid = com2.Parameters.Add("?id", MySqlDbType.Int32);
      pts = com2.Parameters.Add("?ts", MySqlDbType.Timestamp);
      com2.Prepare();

      pname.Value = "test 124";
      pid.Value = 124;
      pts.Value = DateTime.Now;
      com2.ExecuteNonQuery();

      pname.Value = "test 125";
      pid.Value = 125;
      pts.Value = DateTime.Now;
      com2.ExecuteNonQuery();
    }

    public void test_dataset() {
      byte[] bin = new byte[50];
      int i;
      for (i = 0; i < 50; i++)
        bin[i] = (byte)i;

      MySqlCommand com = new MySqlCommand();
      com.Connection = myconn;
      com.CommandText =
        "INSERT INTO testall (a_date, a_text, a_blob) VALUES(?, ?, ?)";
      com.Parameters.Add("pdate", DbType.DateTime);
      com.Parameters.Add("ptext", DbType.String);
      com.Parameters.Add("pblob", DbType.Binary);

      com.Parameters["pdate"].Value = DateTime.Now;
      com.Parameters["ptext"].Value = "O'Hara";
      com.Parameters["pblob"].Value = System.Text.Encoding.UTF8.GetBytes("äöü");
      com.ExecuteNonQuery();
    }

    public void test_last_insert_id() {
      long n;
      MySqlCommand com;
      com = new MySqlCommand("INSERT INTO authors (authName) VALUES ('test xxx')", myconn);
      com.ExecuteNonQuery();
      com.CommandText = "SELECT LAST_INSERT_ID()";
      n = (long)com.ExecuteScalar();
      Console.WriteLine(n);
    }

    public void test_data_adapter() {
      MySqlCommand com;
      MySqlDataAdapter da;
      DataSet ds;
      DataTable dt;
      MySqlCommandBuilder cb;

      com = new MySqlCommand("SELECT * FROM authors", myconn);
      da = new MySqlDataAdapter(com);
      cb = new MySqlCommandBuilder(da);
      ds = new DataSet();

      da.Fill(ds, "authors");
      dt = ds.Tables["authors"];
      foreach (DataRow row in dt.Rows) {
        if (row["authName"].ToString().Substring(0, 4).ToLower() == "test") {
          Console.WriteLine("delete author " + row["authName"].ToString());
          row.Delete();
        }
      }
      try {
        da.Update(ds, "authors");
      }
      catch (Exception e) {
        Console.WriteLine(e.Message);
      }
    }


  }
}
