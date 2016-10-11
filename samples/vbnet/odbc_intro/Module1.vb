Option Strict On
Imports System.Data
Imports System.Data.Odbc

Module Module1
  Dim odbcconn As OdbcConnection

  Sub Main()
    odbcconn = New OdbcConnection( _
      "Driver={MySQL ODBC 3.51 Driver};Server=192.168.80.128;" + _
      "Database=mylibrary;UID=root;PWD=uranus;Options=3")
    odbcconn.Open()

    Console.WriteLine("--- datareader ---")
    read_publishers_datareader()

    'Console.WriteLine()
    'Console.WriteLine("--- dataset ---")
    'read_publishers_dataset()

    odbcconn.Close()
    Console.WriteLine("Press Return!")
    Console.ReadLine()
  End Sub

  ' sample for OdbcDataReader
  Sub read_publishers_datareader()
    Dim com As OdbcCommand
    Dim dr As OdbcDataReader
    com = New OdbcCommand( _
      "SELECT publID, publName FROM publishers ORDER BY publName", odbcconn)
    dr = com.ExecuteReader()
    While dr.Read()
      Console.WriteLine("id: {0} name: {1}", dr!publID, dr!publName)
    End While
    dr.Close()
  End Sub

  ' sample for Dataset
  Sub read_publishers_dataset()
    Dim da As OdbcDataAdapter
    Dim ds As DataSet
    Dim row As DataRow
    Dim dt As DataTable

    Try
      ds = New DataSet()
      da = New OdbcDataAdapter( _
        "SELECT publID, publName FROM publishers ORDER BY publName", odbcconn)
      da.Fill(ds)
      dt = ds.Tables(0)
      For Each row In dt.Rows
        Console.WriteLine("id: {0} name: {1}", row!publID, row!publName)
      Next
      ds.Dispose()
      da.Dispose()
    Catch e As OdbcException
      MsgBox(e.Message)
    End Try
  End Sub

End Module
