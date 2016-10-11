Option Strict On
Imports MySql.Data.MySqlClient
Imports System.IO
Public Class Form1
  Dim myconn As MySqlConnection
  Dim com As MySqlCommand
  Dim id As Integer

  ' connect to MySQL server, create testpic table
  Private Sub btnConnect_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnConnect.Click
    Try
      myconn = New MySqlConnection( _
          "Data Source=192.168.80.128;Initial Catalog=mylibrary;" + _
          "User ID=root;PWD=uranus")
      myconn.Open()
      com = New MySqlCommand( _
        "CREATE TABLE IF NOT EXISTS testpic " + _
        "  (id INT NOT NULL AUTO_INCREMENT, pic MEDIUMBLOB, PRIMARY KEY (id))", _
        myconn)
      com.ExecuteNonQuery()
      'enable Save button
      btnSave.Enabled = True
    Catch myerror As MySqlException
      MsgBox("Database connection error: " & myerror.Message)
      Me.Close()
    End Try
  End Sub

  ' load file, save it as blob in database
  Private Sub btnSave_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSave.Click
    Dim fs As FileStream
    Dim bindata As Byte()
    Dim picpara As MySqlParameter

    ' prepare INSERT command
    com = New MySqlCommand( _
      "INSERT INTO testpic (pic) VALUES(?pic)", myconn)
    picpara = com.Parameters.Add("?pic", MySqlDbType.MediumBlob)
    com.Prepare()

    ' read JPEG file into Byte array
    fs = New FileStream("test.jpg", FileMode.Open, FileAccess.Read)
    ReDim bindata(CInt(fs.Length))
    fs.Read(bindata, 0, CInt(fs.Length))
    fs.Close()

    ' call INSERT command, use Byte array as parameter
    picpara.Value = bindata
    com.ExecuteNonQuery()

    ' retrieve id of new record
    com.CommandText = "SELECT LAST_INSERT_ID()"
    id = CInt(com.ExecuteScalar())

    ' enable load button
    btnLoad.Enabled = True
  End Sub

  ' load BLOB from database, save as file, show as image
  Private Sub btnLoad_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnLoad.Click
    Dim fs As FileStream
    Dim bindata As Byte()
    Dim ms As New MemoryStream

    com = New MySqlCommand("SELECT pic FROM testpic WHERE id=" & id, myconn)
    bindata = CType(com.ExecuteScalar(), Byte())

    ' show JPEG file
    ms.Write(bindata, 0, bindata.Length)
    PictureBox1.Image = New Bitmap(ms)

    ' save new JPEG file
    fs = New FileStream("test1.jpg", FileMode.Create, FileAccess.Write)
    ms.WriteTo(fs)
    fs.Close()
  End Sub

  ' delete testpic table, end
  Private Sub btnEnd_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnEnd.Click
    com = New MySqlCommand( _
      "DROP TABLE IF EXISTS testpic ", myconn)
    com.ExecuteNonQuery()
    Me.Close()
  End Sub
End Class
