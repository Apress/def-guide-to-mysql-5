VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "BLOB test"
   ClientHeight    =   2951
   ClientLeft      =   52
   ClientTop       =   338
   ClientWidth     =   5395
   LinkTopic       =   "Form1"
   ScaleHeight     =   2951
   ScaleWidth      =   5395
   StartUpPosition =   3  'Windows-Standard
   Begin VB.PictureBox Picture1 
      AutoSize        =   -1  'True
      Height          =   1692
      Left            =   2640
      ScaleHeight     =   1638
      ScaleWidth      =   1885
      TabIndex        =   4
      Top             =   120
      Width           =   1932
   End
   Begin VB.CommandButton Command4 
      Caption         =   "End"
      Height          =   372
      Left            =   120
      TabIndex        =   3
      Top             =   1680
      Width           =   2292
   End
   Begin VB.CommandButton Command3 
      Caption         =   "Load picture from database and save it in test1.jpg"
      Enabled         =   0   'False
      Height          =   492
      Left            =   120
      TabIndex        =   2
      Top             =   1080
      Width           =   2292
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Save test.jpg in database"
      Enabled         =   0   'False
      Height          =   372
      Left            =   120
      TabIndex        =   1
      Top             =   600
      Width           =   2292
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Connect "
      Height          =   372
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   2292
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
' blob\form1.frm
Option Explicit

' uses ADO 2.5
Dim conn As Connection
Dim id As Long

' connect to MySQL
Private Sub Command1_Click()
  Set conn = New Connection
  'options: 16395 = 16384 + 8 + 2 + 1
  '  Don't Optimize Column Width + Return Matching Rows +
  '  Allow Big Results + Change BIGINT Columns to INT
  conn.ConnectionString = "Provider=MSDASQL;" + _
    "DRIVER={MySQL ODBC 3.51 Driver};" + _
    "Server=localhost;UID=root;PWD=uranus;" + _
    "database=mylibrary;Option=16395"
  conn.Open
  ' create test database
  conn.Execute "CREATE TABLE IF NOT EXISTS testpic " + _
      "(id INT NOT NULL AUTO_INCREMENT, pic MEDIUMBLOB, PRIMARY KEY (id))"
  Command2.Enabled = True
End Sub

' save file in table test
Private Sub Command2_Click()
  Dim rec As New Recordset
  Dim fname As String
  Dim st As New Stream
  
  ' open file
  fname = App.Path + "\test.jpg"
  st.Type = adTypeBinary
  st.Open
  st.LoadFromFile fname
  
  ' open table, save file
  rec.CursorLocation = adUseClient
  rec.Open "SELECT * FROM testpic LIMIT 1", conn, adOpenKeyset, adLockOptimistic
  rec.AddNew
  rec!pic = st.Read
  rec.Update
  rec.Close
  st.Close
  
  ' remember id of inserted recordset
  id = LastInsertedID()
  Command3.Enabled = True
End Sub

' load file from table test
Private Sub Command3_Click()
  Dim rec As New Recordset
  Dim fname As String
  Dim st As New Stream
  
  ' stream for file to save
  fname = App.Path + "\test1.jpg"
  st.Type = adTypeBinary
  st.Open
  
  ' retrieve data from database
  rec.CursorLocation = adUseClient
  rec.Open "SELECT pic FROM testpic WHERE id = " & id, conn, adOpenKeyset, adLockReadOnly
  st.Write rec!pic
  rec.Close
  
  ' save to file
  st.SaveToFile fname, adSaveCreateOverWrite
  st.Close
  
  ' show image in Picture control
  Picture1.Picture = LoadPicture(fname)
End Sub


' end
Private Sub Command4_Click()
  conn.Execute "DROP TABLE IF EXISTS testpic "
  End
End Sub

' get AUTO_INCREMENT id
Private Function LastInsertedID() As Long
  Dim rec As New Recordset
  rec.CursorLocation = adUseClient
  rec.Open "SELECT LAST_INSERT_ID()", conn
  LastInsertedID = rec.Fields(0)
End Function

