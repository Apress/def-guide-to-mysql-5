Option Strict On
Imports System.Data
Imports MySql.Data.MySqlClient

Module Module1
  Dim myconn As MySqlConnection

  Sub Main()
    Try
      myconn = New MySqlConnection( _
          "Data Source=192.168.80.128;Initial Catalog=mylibrary;" + _
          "User ID=root;PWD=uranus")
      myconn.Open()
    Catch myerror As MySqlException
      MsgBox("Database connection error: " & myerror.Message)
      End
    End Try

    ' test_scalar()
    ' test_reader()
    ' test_reader_multi_select()
    ' test_param()
    test_last_insert_id()
    test_data_adapter()

    myconn.Close()
    Console.WriteLine("Press Return ")
    Console.ReadLine()
  End Sub


  Sub test_param()
    'Dim com1 As MySqlCommand
    'com1 = myconn.CreateCommand()
    'com1.CommandText = _
    '  "INSERT INTO authors (authName, authID, ts) VALUES(?name, ?id, ?ts)"
    'com1.Parameters.Add("?name", "test 123")
    'com1.Parameters.Add("?id", 123)
    'com1.Parameters.Add("?ts", DateTime.Now())
    'com1.ExecuteNonQuery()

    Dim com2 As MySqlCommand
    Dim pname, pid, pts As MySqlParameter
    com2 = myconn.CreateCommand()
    com2.CommandText = _
      "INSERT INTO authors (authName, authID, ts) VALUES(?name, ?id, ?ts)"
    pname = com2.Parameters.Add("?name", MySqlDbType.VarChar)
    pid = com2.Parameters.Add("?id", MySqlDbType.Int32)
    pts = com2.Parameters.Add("?ts", MySqlDbType.Timestamp)
    com2.Prepare()

    pname.Value = "test 124"
    pid.Value = 124
    pts.Value = DateTime.Now
    com2.ExecuteNonQuery()

    pname.Value = "test 125"
    pid.Value = 125
    pts.Value = DateTime.Now
    com2.ExecuteNonQuery()

    Stop
  End Sub

  Sub test_reader()
    Dim i As Integer, s As String
    Dim sstr As New IO.StringWriter
    Dim com As New MySqlCommand( _
      "SELECT publID, publName FROM publishers", myconn)
    Dim dr As MySqlDataReader = com.ExecuteReader()
    While dr.Read()
      i = CInt(dr!publID)
      s = CStr(dr!publName)
      sstr.WriteLine("id: {0} name: {1}", dr!publID, dr!publName)
    End While
    Console.WriteLine(sstr)
    sstr.Close()
    dr.Close()
  End Sub

  Sub test_reader_multi_select()
    Dim i As Integer
    Dim com As New MySqlCommand( _
      "SELECT * FROM authors LIMIT 3;SELECT COUNT(*) FROM authors;SELECT 1+2", myconn)
    Dim dr As MySqlDataReader = com.ExecuteReader()
    Do
      Console.WriteLine("-----")
      While dr.Read()
        For i = 0 To dr.FieldCount - 1
          If dr.IsDBNull(i) Then
            Console.Write("NULL ")
          Else
            Console.Write(dr.GetString(i) + " ")
          End If
        Next
        Console.WriteLine()
      End While
    Loop While dr.NextResult()
    dr.Close()
  End Sub

  Sub test_scalar()
    Dim obj As Object
    Dim dt As DateTime
    Dim com As New MySqlCommand("SELECT MAX(ts) FROM authors ", myconn)
    obj = com.ExecuteScalar()
    dt = CDate(obj)
    Stop
  End Sub

  Sub test_last_insert_id()
    Dim n As Long
    Dim com As New MySqlCommand()
    com.Connection = myconn
    com.CommandText = "INSERT INTO authors (authName) VALUES ('test xxx')"
    com.ExecuteNonQuery()
    com.CommandText = "SELECT LAST_INSERT_ID()"
    n = CLng(com.ExecuteScalar())
    Console.WriteLine(n)
  End Sub

  Sub test_data_adapter()
    Dim com As New MySqlCommand("SELECT * FROM authors", myconn)
    Dim da As New MySqlDataAdapter(com)        'connection between MySQL and the DataSet
    Dim cb As New MySqlCommandBuilder(da)      'necessary for updates
    Dim ds As New DataSet()                    'new DataSet
    da.Fill(ds, "authors")                     'creates DataTable "authors" in ds
    Dim dt As DataTable = ds.Tables("authors") 'read DataTable
    Dim row As DataRow
    For Each row In dt.Rows                    'loop through all records
      If LCase(Left(CStr(row!authName), 4)) = "test" Then   'change data
        Console.WriteLine("delete author " & row!authName.ToString)
        row.Delete()
      End If
    Next
    Try
      da.Update(ds, "authors")
    Catch e As Exception
      MsgBox(e.Message)
    End Try

  End Sub
End Module


