VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Insert title into database mylibrary "
   ClientHeight    =   2366
   ClientLeft      =   52
   ClientTop       =   338
   ClientWidth     =   5720
   LinkTopic       =   "Form1"
   ScaleHeight     =   2366
   ScaleWidth      =   5720
   StartUpPosition =   3  'Windows-Standard
   Begin VB.TextBox txtPublisher 
      Height          =   288
      Left            =   1200
      TabIndex        =   7
      Top             =   1680
      Width           =   2892
   End
   Begin VB.TextBox txtAuthor 
      Height          =   288
      Left            =   1200
      TabIndex        =   5
      Text            =   "b"
      Top             =   600
      Width           =   2892
   End
   Begin VB.TextBox txtTitle 
      Height          =   288
      Left            =   1200
      TabIndex        =   2
      Text            =   "a"
      Top             =   120
      Width           =   2892
   End
   Begin VB.CommandButton cmdEnd 
      Caption         =   "End"
      Height          =   372
      Left            =   4680
      TabIndex        =   1
      Top             =   600
      Width           =   972
   End
   Begin VB.CommandButton cmdSave 
      Caption         =   "Save data"
      Height          =   372
      Left            =   4680
      TabIndex        =   0
      Top             =   120
      Width           =   972
   End
   Begin VB.Label Label5 
      Caption         =   "You may leave this empty"
      ForeColor       =   &H00FF0000&
      Height          =   252
      Left            =   1320
      TabIndex        =   9
      Top             =   2040
      Width           =   2412
   End
   Begin VB.Label Label4 
      Caption         =   "Last name first, i.e. King Steven! Separate authors with ;"
      ForeColor       =   &H00FF0000&
      Height          =   372
      Left            =   1320
      TabIndex        =   8
      Top             =   960
      Width           =   2412
   End
   Begin VB.Label Label3 
      Caption         =   "Publisher"
      Height          =   252
      Left            =   120
      TabIndex        =   6
      Top             =   1680
      Width           =   972
   End
   Begin VB.Label Label2 
      Caption         =   "Authors"
      Height          =   252
      Left            =   120
      TabIndex        =   4
      Top             =   600
      Width           =   972
   End
   Begin VB.Label Label1 
      Caption         =   "Title"
      Height          =   252
      Left            =   120
      TabIndex        =   3
      Top             =   120
      Width           =   852
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim conn As Connection

' connect to MySQL
Private Sub Form_Load()
  ValidateInput
  Set conn = New Connection
  conn.ConnectionString = "Provider=MSDASQL;" + _
    "DRIVER={MySQL ODBC 3.51 Driver};" + _
    "Server=localhost;UID=root;PWD=uranus;" + _
    "database=mylibrary;Option=16387"
  conn.Open
End Sub

' save data
Private Sub cmdSave_Click()
  ' SaveData_WithRecordsets
  SaveData_WithSQLCommands
  MsgBox "Data saved"
  txtAuthor = "": txtTitle = "": txtPublisher = ""
End Sub

' save data with recordsets
Private Sub SaveData_WithRecordsets()
  Dim i&, titleID&, authID&, publID&
  Dim authors_array
  Dim authors As New Recordset, titles As New Recordset
  Dim publishers As New Recordset, rel_title_author As New Recordset
  ' open recordsets
  authors.CursorLocation = adUseClient
  titles.CursorLocation = adUseClient
  publishers.CursorLocation = adUseClient
  rel_title_author.CursorLocation = adUseClient
  authors.Open "SELECT * FROM authors LIMIT 1", conn, adOpenStatic, adLockOptimistic
  titles.Open "SELECT * FROM titles LIMIT 1", conn, adOpenStatic, adLockOptimistic
  publishers.Open "SELECT * FROM publishers LIMIT 1", conn, adOpenStatic, adLockOptimistic
  rel_title_author.Open "SELECT * FROM rel_title_author LIMIT 1", conn, adOpenStatic, adLockOptimistic
  
  ' save publisher (if specified)
  If Trim(txtPublisher) <> "" Then
    publishers.AddNew
    publishers!publName = Trim(txtPublisher)
    publishers.Update
    publID = LastInsertedID()
  End If
  
  ' save title
  titles.AddNew
  titles!Title = Trim(txtTitle)
  If publID <> 0 Then titles!publID = publID
  titles.Update
  titleID = LastInsertedID()
  
  ' save authors and rel_title_author
  authors_array = Split(txtAuthor, ";")
  For i = LBound(authors_array) To UBound(authors_array)
    authors.AddNew
    authors!authName = Trim(authors_array(i))
    authors.Update
    authID = LastInsertedID()
    rel_title_author.AddNew
    rel_title_author!titleID = titleID
    rel_title_author!authID = authID
    rel_title_author.Update
  Next
End Sub

' save data with SQL commands
Private Sub SaveData_WithSQLCommands()
  Dim i&, titleID&, authID&, publID&
  Dim authors_array
  ' save publisher (if specified)
  If Trim(txtPublisher) <> "" Then
    conn.Execute "INSERT INTO publishers (publName) " & _
                 "VALUES ('" & Quote(Trim(txtPublisher)) & "')"
    publID = LastInsertedID()
  End If
  
  ' save title
  conn.Execute "INSERT INTO titles (title, publID) " & _
               "VALUES ('" & Quote(Trim(txtTitle)) & "', " & _
                        IIf(publID <> 0, publID, "NULL") & ")"
  titleID = LastInsertedID()
  
  ' save authors and rel_title_author
  authors_array = Split(txtAuthor, ";")
  For i = LBound(authors_array) To UBound(authors_array)
    conn.Execute "INSERT INTO authors (authName) " & _
                 "VALUES ('" & Quote(Trim(authors_array(i))) & "')"
    authID = LastInsertedID()
    conn.Execute "INSERT INTO rel_title_author (titleID, authID) " & _
                 "VALUES (" & titleID & ", " & authID & ")"
  Next
End Sub

' retrieve AUTO_INCREMENT value of last inserted record
Private Function LastInsertedID() As Long
  Dim rec As New Recordset
  rec.CursorLocation = adUseClient
  rec.Open "SELECT LAST_INSERT_ID()", conn
  LastInsertedID = rec.Fields(0)
End Function

' quote ' " and \; replace chr(0) by \0
Function Quote$(tmp$)
  tmp = Replace(tmp, "\", "\\")
  tmp = Replace(tmp, """", "\""")
  tmp = Replace(tmp, "'", "\'")
  Quote = Replace(tmp, Chr(0), "\0")
End Function

' end
Private Sub cmdEnd_Click()
  End
End Sub

' enable save button only if input seems to be ok
Private Sub txtAuthor_Change()
  ValidateInput
End Sub
Private Sub txtPublisher_Change()
  ValidateInput
End Sub
Private Sub txtTitle_Change()
  ValidateInput
End Sub
Private Sub ValidateInput()
  If Trim(txtTitle.Text) <> "" And Trim(txtAuthor.Text) <> "" Then
    cmdSave.Enabled = True
  Else
    cmdSave.Enabled = False
  End If
End Sub
