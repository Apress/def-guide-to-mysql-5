Imports MySql.Data.MySqlClient
Public Class Form1
  Dim myconn As MySqlConnection

  Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click
    Try
      myconn = New MySqlConnection( _
          "Data Source=192.168.80.128;Initial Catalog=mylibrary;" + _
          "User ID=root;PWD=uranus")
      myconn.Open()
    Catch myerror As MySqlException
      MsgBox("Database connection error: " & myerror.Message)
      Me.Close()
    End Try
    Button2.Enabled = True
  End Sub

  Private Sub Button2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button2.Click
    Dim com As MySqlCommand
    Dim dr As MySqlDataReader
    com = New MySqlCommand( _
      "SELECT publID, publName FROM publishers ORDER BY publName", _
      myconn)
    dr = com.ExecuteReader()
    While dr.Read()
      TextBox1.AppendText("id = " & dr!publID & ",  name = " & dr!publName & vbCrLf)
    End While
    dr.Close()
  End Sub


  Private Sub Button3_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button3.Click
    Me.Close()
  End Sub
End Class
