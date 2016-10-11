VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "MyVbQL: Set column authors of table mylibrary.titles "
   ClientHeight    =   3848
   ClientLeft      =   52
   ClientTop       =   338
   ClientWidth     =   7150
   LinkTopic       =   "Form1"
   ScaleHeight     =   3848
   ScaleWidth      =   7150
   StartUpPosition =   3  'Windows-Standard
   Begin VB.TextBox Text1 
      Height          =   1885
      Left            =   117
      Locked          =   -1  'True
      MultiLine       =   -1  'True
      ScrollBars      =   3  'Beides
      TabIndex        =   5
      Top             =   1755
      Width           =   6799
   End
   Begin VB.CommandButton Command3 
      Caption         =   "Change authors column using a MYSQL_RS object"
      Height          =   612
      Left            =   3978
      TabIndex        =   4
      Top             =   702
      Width           =   1932
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Connect to MySQL"
      Height          =   598
      Left            =   120
      TabIndex        =   2
      Top             =   702
      Width           =   1692
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Change authors column using a MYSQL_RS object"
      Height          =   612
      Left            =   1920
      TabIndex        =   1
      Top             =   702
      Width           =   1932
   End
   Begin VB.CommandButton Command4 
      Caption         =   "End"
      Height          =   598
      Left            =   6084
      TabIndex        =   0
      Top             =   702
      Width           =   852
   End
   Begin VB.Label Label2 
      Caption         =   "Output:"
      Height          =   247
      Left            =   117
      TabIndex        =   6
      Top             =   1521
      Width           =   1183
   End
   Begin VB.Label Label1 
      Caption         =   $"Form1.frx":0000
      Height          =   481
      Left            =   117
      TabIndex        =   3
      Top             =   117
      Width           =   6916
      WordWrap        =   -1  'True
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
' to make this example work, you must add the column authors
' to the table mylibrary.titles:
'
' USE mylibrary
' ALTER TABLE titles ADD authors VARCHAR(255)

' authors_for_titles_myvbql
Option Explicit
Dim conn As New MYSQL_CONNECTION


' start
Private Sub Form_Load()
  Command2.Enabled = False
  Command3.Enabled = False
End Sub

' connect
Private Sub Command1_Click()
  conn.OpenConnection "localhost", "root", "uranus", "mylibrary"
  Text1.Text = "connected"
  Command2.Enabled = True
  Command3.Enabled = True
End Sub

' change titles.authors
Private Sub Command2_Click()
  Dim authors_str, titleID
  Dim titles As MYSQL_RS
  Dim authors As MYSQL_RS
  
  ' Recordset to change titles.autors column
  Set titles = conn.Execute( _
    "SELECT titleID, authors FROM titles")
  
  ' loop over all titles
  While Not titles.EOF
    titleID = titles.Fields("titleID").Value
    
    ' get all authors of current title
    Set authors = conn.Execute( _
      "SELECT authname FROM authors, rel_title_author " & _
      "WHERE authors.authID=rel_title_author.authID " & _
      "  AND rel_title_author.titleID = " & titleID & " " & _
      "ORDER BY authName")
    
    ' loop over all authors
    authors_str = ""
    Do While Not authors.EOF
      ' build string with all author names
      If Not IsNull(authors.Fields("authName").Value) Then
        If authors_str <> "" Then authors_str = authors_str + "; "
        authors_str = authors_str & authors.Fields("authName").Value
      End If
      authors.MoveNext
    Loop
    authors.CloseRecordset
    
    ' save string in authors column of titles Recordset
    If Len(authors_str) > 254 Then _
      authors_str = Left(authors_str, 254)
    titles.Fields("authors").Value = authors_str
    titles.Update
    titles.MoveNext
  Wend
  titles.CloseRecordset
  Text1.Text = Text1.Text + vbCrLf + "done"
End Sub

' test
Private Sub Command3_Click()
  Dim titles As MYSQL_RS
  Set titles = conn.Execute( _
    "SELECT title, authors FROM titles ORDER BY title")
  Do While Not titles.EOF
    Text1.Text = Text1.Text + vbCrLf + _
      titles.Fields("title") + ": " + _
      titles.Fields("authors")
    titles.MoveNext
  Loop
  titles.CloseRecordset
End Sub

'end
Private Sub Command4_Click()
  End
End Sub


' quote ' " and \; replace chr(0) by \0
Function Quote$(tmp$)
  tmp = Replace(tmp, "\", "\\")
  tmp = Replace(tmp, """", "\""")
  tmp = Replace(tmp, "'", "\'")
  Quote = Replace(tmp, Chr(0), "\0")
End Function

