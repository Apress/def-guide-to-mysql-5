VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Set column authors of table mylibrary.titles "
   ClientHeight    =   1976
   ClientLeft      =   52
   ClientTop       =   338
   ClientWidth     =   4927
   LinkTopic       =   "Form1"
   ScaleHeight     =   1976
   ScaleWidth      =   4927
   StartUpPosition =   3  'Windows-Standard
   Begin VB.CommandButton Command2b 
      Caption         =   "Change authors column using conn.Execute"
      Height          =   492
      Left            =   1920
      TabIndex        =   4
      Top             =   1440
      Width           =   1932
   End
   Begin VB.CommandButton Command3 
      Caption         =   "End"
      Height          =   372
      Left            =   3960
      TabIndex        =   3
      Top             =   1200
      Width           =   852
   End
   Begin VB.CommandButton Command2a 
      Caption         =   "Change authors column using a read/write Recordset"
      Height          =   612
      Left            =   1920
      TabIndex        =   2
      Top             =   720
      Width           =   1932
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Connect to MySQL"
      Height          =   372
      Left            =   120
      TabIndex        =   0
      Top             =   1200
      Width           =   1692
   End
   Begin VB.Label Label1 
      Caption         =   $"Form1.frx":0000
      Height          =   732
      Left            =   120
      TabIndex        =   1
      Top             =   120
      Width           =   4692
      WordWrap        =   -1  'True
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
' titles_for_authors
Option Explicit

Dim conn As Connection
Dim rec As Recordset

' to make this example work, you must add the column authors
' to the table mylibrary.titles:
' USE mylibrary
' ALTER TABLE titles ADD authors VARCHAR(255)

Private Sub Command1_Click()
  Set conn = New Connection
  ' conn.ConnectionString = "DSN=mysql-mylibrary;UID=root;PWD=uranus"
  conn.ConnectionString = "Provider=MSDASQL;" + _
    "DRIVER={MySQL ODBC 3.51 Driver};" + _
    "Server=localhost;UID=root;PWD=uranus;" + _
    "database=mylibraryutf8;Option=16387"
  conn.Open
  Command2a.Enabled = True
  Command2b.Enabled = True
End Sub

' variant 1: using a read/write Recordset to change data
Private Sub Command2a_Click()
  Dim authors_str As String
  Dim titles As New Recordset
  Dim authors As New Recordset
  
  ' titles Recordset to change authors column; client-side, read/write
  titles.CursorLocation = adUseClient
  titles.Open "SELECT titleID, authors FROM titles", conn, adOpenStatic, adLockOptimistic
  
  ' authors Recordset: client-side, readonly, disconnected
  authors.CursorLocation = adUseClient
  authors.Open "SELECT titleID, authname from authors, rel_title_author " & _
               "WHERE authors.authID=rel_title_author.authID", conn, adOpenStatic, adLockReadOnly
  authors.Sort = "titleID, authname"
  Set authors.ActiveConnection = Nothing
  
  While Not titles.EOF
    Debug.Print titles!titleID;
    authors_str = ""
    authors.MoveFirst
    authors.Find "titleID=" & titles!titleID
    While Not authors.EOF
      If authors_str <> "" Then authors_str = authors_str + "; "
      authors_str = authors_str & authors!authName
      authors.MoveNext
      authors.Find "titleID=" & titles!titleID
    Wend
    Debug.Print authors_str
    If authors_str <> "" Then
      titles!authors = authors_str
      titles.Update
    End If
    titles.MoveNext
  Wend
End Sub

' variant 2
Private Sub Command2b_Click()
  Dim authors_str As String, titleID As Long
  Dim authors As New Recordset
  
  ' authors Recordset: client-side, readonly, disconnected
  authors.CursorLocation = adUseClient
  authors.Open "SELECT titleID, authname from authors, rel_title_author " & _
               "WHERE authors.authID=rel_title_author.authID " & _
               "ORDER BY titleID, authName", _
               conn, adOpenStatic, adLockReadOnly
  authors.Sort = "titleID, authname"
  Set authors.ActiveConnection = Nothing
  
  ' loop through titles
  While Not authors.EOF
    titleID = authors!titleID
    authors_str = ""
    ' find all authors for current titleID
    authors_str = ""
    Do While Not authors.EOF
      ' exit inner loop if next titleID
      If authors!titleID <> titleID Then
        Exit Do
      End If
      ' build string with authors names
      If Not IsNull(authors!authName) Then
        If authors_str <> "" Then authors_str = authors_str + "; "
        authors_str = authors_str & authors!authName
      End If
      authors.MoveNext
    Loop
    
    ' save authors field
    Debug.Print authors_str
    If authors_str <> "" Then
      conn.Execute "UPDATE titles " & _
                   "SET authors = '" & Quote(authors_str) & "'" & _
                   "WHERE titleID=" & titleID
    End If
  Wend
End Sub

' quote ' " and \; replace chr(0) by \0
Function Quote$(tmp$)
  tmp = Replace(tmp, "\", "\\")
  tmp = Replace(tmp, """", "\""")
  tmp = Replace(tmp, "'", "\'")
  Quote = Replace(tmp, Chr(0), "\0")
End Function

Private Sub Command3_Click()
  End
End Sub

Private Sub Form_Load()
  Command2a.Enabled = False
  Command2b.Enabled = False
End Sub
