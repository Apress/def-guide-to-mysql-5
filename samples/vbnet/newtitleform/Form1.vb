Option Strict On
Imports MySql.Data.MySqlClient
Public Class Form1
  Inherits System.Windows.Forms.Form

#Region " Vom Windows Form Designer generierter Code "

  Public Sub New()
    MyBase.New()

    ' Dieser Aufruf ist für den Windows Form-Designer erforderlich.
    InitializeComponent()

    ' Initialisierungen nach dem Aufruf InitializeComponent() hinzufügen

  End Sub

  ' Die Form überschreibt den Löschvorgang der Basisklasse, um Komponenten zu bereinigen.
  Protected Overloads Overrides Sub Dispose(ByVal disposing As Boolean)
    If disposing Then
      If Not (components Is Nothing) Then
        components.Dispose()
      End If
    End If
    MyBase.Dispose(disposing)
  End Sub

  ' Für Windows Form-Designer erforderlich
  Private components As System.ComponentModel.IContainer

  'HINWEIS: Die folgende Prozedur ist für den Windows Form-Designer erforderlich
  'Sie kann mit dem Windows Form-Designer modifiziert werden.
  'Verwenden Sie nicht den Code-Editor zur Bearbeitung.
  Friend WithEvents Label1 As System.Windows.Forms.Label
  Friend WithEvents Label2 As System.Windows.Forms.Label
  Friend WithEvents Label3 As System.Windows.Forms.Label
  Friend WithEvents txtTitle As System.Windows.Forms.TextBox
  Friend WithEvents txtAuthors As System.Windows.Forms.TextBox
  Friend WithEvents Label4 As System.Windows.Forms.Label
  Friend WithEvents txtPublisher As System.Windows.Forms.TextBox
  Friend WithEvents Label5 As System.Windows.Forms.Label
  Friend WithEvents btnSave As System.Windows.Forms.Button
  Friend WithEvents btnEnd As System.Windows.Forms.Button
  <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
    Me.Label1 = New System.Windows.Forms.Label()
    Me.Label2 = New System.Windows.Forms.Label()
    Me.Label3 = New System.Windows.Forms.Label()
    Me.txtTitle = New System.Windows.Forms.TextBox()
    Me.txtAuthors = New System.Windows.Forms.TextBox()
    Me.Label4 = New System.Windows.Forms.Label()
    Me.txtPublisher = New System.Windows.Forms.TextBox()
    Me.Label5 = New System.Windows.Forms.Label()
    Me.btnSave = New System.Windows.Forms.Button()
    Me.btnEnd = New System.Windows.Forms.Button()
    Me.SuspendLayout()
    '
    'Label1
    '
    Me.Label1.Location = New System.Drawing.Point(16, 8)
    Me.Label1.Name = "Label1"
    Me.Label1.Size = New System.Drawing.Size(72, 16)
    Me.Label1.TabIndex = 0
    Me.Label1.Text = "Title"
    '
    'Label2
    '
    Me.Label2.Location = New System.Drawing.Point(16, 40)
    Me.Label2.Name = "Label2"
    Me.Label2.Size = New System.Drawing.Size(72, 16)
    Me.Label2.TabIndex = 1
    Me.Label2.Text = "Authors"
    '
    'Label3
    '
    Me.Label3.Location = New System.Drawing.Point(24, 128)
    Me.Label3.Name = "Label3"
    Me.Label3.Size = New System.Drawing.Size(72, 16)
    Me.Label3.TabIndex = 2
    Me.Label3.Text = "Publisher"
    '
    'txtTitle
    '
    Me.txtTitle.Location = New System.Drawing.Point(96, 8)
    Me.txtTitle.Name = "txtTitle"
    Me.txtTitle.Size = New System.Drawing.Size(216, 22)
    Me.txtTitle.TabIndex = 3
    Me.txtTitle.Text = ""
    '
    'txtAuthors
    '
    Me.txtAuthors.Location = New System.Drawing.Point(96, 40)
    Me.txtAuthors.Name = "txtAuthors"
    Me.txtAuthors.Size = New System.Drawing.Size(216, 22)
    Me.txtAuthors.TabIndex = 4
    Me.txtAuthors.Text = ""
    '
    'Label4
    '
    Me.Label4.Location = New System.Drawing.Point(96, 72)
    Me.Label4.Name = "Label4"
    Me.Label4.Size = New System.Drawing.Size(208, 32)
    Me.Label4.TabIndex = 5
    Me.Label4.Text = "Last name first, i.e. King Stephen! Separate authors with ;"
    '
    'txtPublisher
    '
    Me.txtPublisher.Location = New System.Drawing.Point(96, 128)
    Me.txtPublisher.Name = "txtPublisher"
    Me.txtPublisher.Size = New System.Drawing.Size(216, 22)
    Me.txtPublisher.TabIndex = 4
    Me.txtPublisher.Text = ""
    '
    'Label5
    '
    Me.Label5.Location = New System.Drawing.Point(96, 160)
    Me.Label5.Name = "Label5"
    Me.Label5.Size = New System.Drawing.Size(208, 16)
    Me.Label5.TabIndex = 6
    Me.Label5.Text = "You may leave this empty."
    '
    'btnSave
    '
    Me.btnSave.Location = New System.Drawing.Point(344, 120)
    Me.btnSave.Name = "btnSave"
    Me.btnSave.Size = New System.Drawing.Size(104, 24)
    Me.btnSave.TabIndex = 7
    Me.btnSave.Text = "Save data"
    '
    'btnEnd
    '
    Me.btnEnd.Location = New System.Drawing.Point(344, 152)
    Me.btnEnd.Name = "btnEnd"
    Me.btnEnd.Size = New System.Drawing.Size(104, 24)
    Me.btnEnd.TabIndex = 8
    Me.btnEnd.Text = "End"
    '
    'Form1
    '
    Me.AutoScaleBaseSize = New System.Drawing.Size(6, 15)
    Me.ClientSize = New System.Drawing.Size(456, 184)
    Me.Controls.AddRange(New System.Windows.Forms.Control() {Me.btnEnd, Me.btnSave, Me.Label5, Me.Label4, Me.txtAuthors, Me.txtTitle, Me.Label3, Me.Label2, Me.Label1, Me.txtPublisher})
    Me.Name = "Form1"
    Me.Text = "Insert title into database mylibraryodbc"
    Me.ResumeLayout(False)

  End Sub

#End Region

  Dim mysqlConn As MySqlConnection
  Dim insertPublisherCom, insertAuthorCom, _
      insertTitleCom, insertRelAuthTitleCom, _
      selectPublisherCom, selectAuthorCom, _
      lastIDCom As MySqlCommand

  Private Sub Form1_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
    ' connect to database
    mysqlConn = New MySqlConnection( _
      "Data Source=192.168.80.128;Initial Catalog=mylibrary;" + _
      "User ID=root;PWD=uranus")
    mysqlConn.Open()

    ' build command to insert author
    insertAuthorCom = New MySqlCommand( _
      "INSERT INTO authors (authName) VALUES (?authName)", mysqlConn)
    insertAuthorCom.Parameters.Add("?authName", MySqlDbType.VarChar)
    insertAuthorCom.Prepare()

    ' build command to find author
    selectAuthorCom = New MySqlCommand( _
      "SELECT authID FROM authors WHERE authName = ?authName LIMIT 1", _
      mysqlConn)
    selectAuthorCom.Parameters.Add("?authName", MySqlDbType.VarChar)
    selectAuthorCom.Prepare()

    ' build command to insert title
    insertTitleCom = New MySqlCommand( _
      "INSERT INTO titles (title, publID) VALUES (?title, ?publID)", _
      mysqlConn)
    insertTitleCom.Parameters.Add("?title", MySqlDbType.VarChar)
    insertTitleCom.Parameters.Add("?publID", MySqlDbType.Int32)
    insertTitleCom.Prepare()

    ' build command to insert publisher
    insertPublisherCom = New MySqlCommand( _
      "INSERT INTO publishers (publName) VALUES (?publName)", mysqlConn)
    insertPublisherCom.Parameters.Add("?publName", MySqlDbType.VarChar)
    insertTitleCom.Prepare()

    ' build command to find publisher
    selectPublisherCom = New MySqlCommand( _
      "SELECT publID FROM publishers WHERE publName = ?publName LIMIT 1", _
      mysqlConn)
    selectPublisherCom.Parameters.Add("?publName", MySqlDbType.VarChar)
    selectPublisherCom.Prepare()

    ' build command to insert IDs into rel_title_author
    insertRelAuthTitleCom = New MySqlCommand( _
      "INSERT INTO rel_title_author (titleID, authID) VALUES (?titleID, ?authId)", _
      mysqlConn)
    insertRelAuthTitleCom.Parameters.Add("?titleID", MySqlDbType.Int32)
    insertRelAuthTitleCom.Parameters.Add("?authID", MySqlDbType.Int32)
    insertRelAuthTitleCom.Prepare()

    ' build command to get LAST_INSERT_ID
    lastIDCom = New MySqlCommand( _
      "SELECT LAST_INSERT_ID()", mysqlConn)
  End Sub

  Private Sub btnSave_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSave.Click
    Dim publID, titleID As Integer
    Dim result As Object
    Dim author, authors() As String
    txtTitle.Text = Trim(txtTitle.Text)
    txtAuthors.Text = Trim(txtAuthors.Text)
    txtPublisher.Text = Trim(txtPublisher.Text)
    If txtTitle.Text = "" Or txtAuthors.Text = "" Then
      MsgBox("Please specify title and authors!")
      Exit Sub
    End If

    ' find or save publisher
    If txtPublisher.Text <> "" Then
      ' does the publisher already exist?
      selectPublisherCom.Parameters("?publName").Value = txtPublisher.Text
      result = selectPublisherCom.ExecuteScalar()
      If result Is Nothing Then
        insertPublisherCom.Parameters("?publName").Value = txtPublisher.Text
        insertPublisherCom.ExecuteNonQuery()
        publID = CInt(lastIDCom.ExecuteScalar())
      Else
        publID = CInt(result)
      End If
    End If

    ' save title
    insertTitleCom.Parameters("?title").Value = txtTitle.Text
    If publID > 0 Then
      insertTitleCom.Parameters("?publID").Value = publID
    Else
      insertTitleCom.Parameters("?publID").Value = DBNull.Value
    End If
    insertTitleCom.ExecuteNonQuery()
    titleID = CInt(lastIDCom.ExecuteScalar())

    ' save authors 
    authors = Split(txtAuthors.Text, ";")
    insertRelAuthTitleCom.Parameters("?titleID").Value = titleID
    For Each author In authors
      'does the autor already exist?
      selectAuthorCom.Parameters("?authName").Value = author
      result = selectAuthorCom.ExecuteScalar()
      If result Is Nothing Then
        ' no, insert new author
        insertAuthorCom.Parameters("?authName").Value = author
        insertAuthorCom.ExecuteNonQuery()
        insertRelAuthTitleCom.Parameters("?authID").Value = _
          CInt(lastIDCom.ExecuteScalar())
      Else
        insertRelAuthTitleCom.Parameters("?authID").Value = _
          CInt(result)
      End If
      ' save rel_title_authors entry
      insertRelAuthTitleCom.ExecuteNonQuery()
    Next

    MsgBox("Your input has been saved")
    txtTitle.Text = ""
    txtAuthors.Text = ""
    txtPublisher.Text = ""
  End Sub

  Private Sub btnEnd_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnEnd.Click
    Me.Close()
  End Sub
End Class
