using System;
using System.Data.Odbc;

namespace odbc_connect {
  class mainclass         {
    [STAThread]
    static void Main(string[] args) {
      Odbctest tst = new Odbctest();
      tst.ReadPublishersDataset();
      Console.WriteLine("Return drücken");
      Console.ReadLine();
    }
  }

  class Odbctest {
    OdbcConnection odbcconn;

    public Odbctest() {     // use constructor to connect
      odbcconn = new OdbcConnection(
        "Driver={MySQL ODBC 3.51 Driver};Server=192.168.80.128;" + 
        "Database=mylibrary;UID=root;PWD=uranus;Options=3");
      odbcconn.Open();
    }

    public void ReadPublishersDataset() {
      OdbcCommand com = new OdbcCommand( 
        "SELECT publID, publName FROM publishers ORDER BY publName", odbcconn);
      OdbcDataReader dr = com.ExecuteReader();
      while(dr.Read()) {
        Console.WriteLine("id: {0} name: {1}", dr["publID"], dr["publName"]);
      }
      dr.Close();
    }
  }
}
