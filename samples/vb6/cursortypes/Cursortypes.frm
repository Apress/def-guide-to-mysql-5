VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Test available Recordset types"
   ClientHeight    =   8138
   ClientLeft      =   65
   ClientTop       =   351
   ClientWidth     =   8372
   LinkTopic       =   "Form4"
   ScaleHeight     =   8138
   ScaleWidth      =   8372
   StartUpPosition =   3  'Windows-Standard
   Begin VB.CommandButton cmdOpen 
      Caption         =   "Open Recordset, loop through all records, close "
      Height          =   855
      Left            =   5400
      TabIndex        =   42
      Top             =   120
      Width           =   1575
   End
   Begin VB.TextBox txtProperties 
      Height          =   2532
      Left            =   4080
      MultiLine       =   -1  'True
      ScrollBars      =   3  'Beides
      TabIndex        =   40
      Text            =   "Cursortypes.frx":0000
      Top             =   5520
      Width           =   4212
   End
   Begin VB.CheckBox chkAddNew 
      Caption         =   "AddNew"
      ForeColor       =   &H00FF0000&
      Height          =   255
      Left            =   240
      TabIndex        =   38
      Top             =   5520
      Width           =   1572
   End
   Begin VB.CheckBox chkUpdateBatch 
      Caption         =   "UpdateBatch"
      ForeColor       =   &H00FF0000&
      Height          =   255
      Left            =   2040
      TabIndex        =   37
      Top             =   7320
      Width           =   1335
   End
   Begin VB.CheckBox chkResync 
      Caption         =   "Resync"
      ForeColor       =   &H00FF0000&
      Height          =   255
      Left            =   2040
      TabIndex        =   36
      Top             =   6240
      Width           =   1695
   End
   Begin VB.CheckBox chkSeek 
      Caption         =   "Seek"
      ForeColor       =   &H00FF0000&
      Height          =   255
      Left            =   2040
      TabIndex        =   35
      Top             =   6600
      Width           =   1695
   End
   Begin VB.CheckBox chkUpdate 
      Caption         =   "Update"
      ForeColor       =   &H00FF0000&
      Height          =   255
      Left            =   2040
      TabIndex        =   34
      Top             =   6960
      Width           =   1695
   End
   Begin VB.CheckBox chkNotify 
      Caption         =   "Notify"
      ForeColor       =   &H00FF0000&
      Height          =   255
      Left            =   2040
      TabIndex        =   33
      Top             =   5880
      Width           =   1695
   End
   Begin VB.CheckBox chkHoldRecords 
      Caption         =   "HoldRecords"
      ForeColor       =   &H00FF0000&
      Height          =   255
      Left            =   240
      TabIndex        =   32
      Top             =   7320
      Width           =   1695
   End
   Begin VB.CheckBox chkMovePrev 
      Caption         =   "MovePrevious"
      ForeColor       =   &H00FF0000&
      Height          =   255
      Left            =   2040
      TabIndex        =   31
      Top             =   5520
      Width           =   1695
   End
   Begin VB.CheckBox chkIndex 
      Caption         =   "Index"
      ForeColor       =   &H00FF0000&
      Height          =   255
      Left            =   240
      TabIndex        =   30
      Top             =   7680
      Width           =   1695
   End
   Begin VB.CheckBox chkFind 
      Caption         =   "Find"
      ForeColor       =   &H00FF0000&
      Height          =   255
      Left            =   240
      TabIndex        =   29
      Top             =   6960
      Width           =   1695
   End
   Begin VB.CheckBox chkApprox 
      Caption         =   "ApproxPosition"
      ForeColor       =   &H00FF0000&
      Height          =   255
      Left            =   240
      TabIndex        =   28
      Top             =   5880
      Width           =   1695
   End
   Begin VB.CheckBox chkBookmark 
      Caption         =   "Bookmark"
      ForeColor       =   &H00FF0000&
      Height          =   255
      Left            =   240
      TabIndex        =   27
      Top             =   6240
      Width           =   1695
   End
   Begin VB.CheckBox chkDelete 
      Caption         =   "Delete"
      ForeColor       =   &H00FF0000&
      Height          =   255
      Left            =   240
      TabIndex        =   26
      Top             =   6600
      Width           =   1695
   End
   Begin VB.CommandButton cmdEnd 
      Caption         =   "End"
      Height          =   375
      Left            =   7080
      TabIndex        =   16
      Top             =   120
      Width           =   1215
   End
   Begin VB.Frame Frame3 
      Caption         =   "CursorLocation"
      Height          =   1215
      Left            =   5400
      TabIndex        =   7
      Top             =   1200
      Width           =   2895
      Begin VB.OptionButton CursorLocationOpt 
         Caption         =   "adUseClient"
         Height          =   255
         Index           =   1
         Left            =   240
         TabIndex        =   13
         Top             =   720
         Width           =   1335
      End
      Begin VB.OptionButton CursorLocationOpt 
         Caption         =   "adUseServer"
         Height          =   255
         Index           =   0
         Left            =   240
         TabIndex        =   12
         Top             =   360
         Value           =   -1  'True
         Width           =   1335
      End
   End
   Begin VB.Frame Frame2 
      Caption         =   "LockType"
      Height          =   1935
      Left            =   2760
      TabIndex        =   6
      Top             =   480
      Width           =   2415
      Begin VB.OptionButton LockTypeOpt 
         Caption         =   "adLockBatchOptimistic"
         Height          =   255
         Index           =   3
         Left            =   240
         TabIndex        =   11
         Top             =   1440
         Width           =   2040
      End
      Begin VB.OptionButton LockTypeOpt 
         Caption         =   "adLockOptimistic"
         Height          =   255
         Index           =   2
         Left            =   240
         TabIndex        =   10
         Top             =   1080
         Width           =   1800
      End
      Begin VB.OptionButton LockTypeOpt 
         Caption         =   "adLockPessimistic"
         Height          =   255
         Index           =   1
         Left            =   240
         TabIndex        =   9
         Top             =   720
         Width           =   1800
      End
      Begin VB.OptionButton LockTypeOpt 
         Caption         =   "adLockReadOnly"
         Height          =   255
         Index           =   0
         Left            =   240
         TabIndex        =   8
         Top             =   360
         Value           =   -1  'True
         Width           =   1800
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "CursorType"
      Height          =   1935
      Left            =   120
      TabIndex        =   1
      Top             =   480
      Width           =   2295
      Begin VB.OptionButton CursorTypeOpt 
         Caption         =   "adOpenKeyset"
         Height          =   255
         Index           =   3
         Left            =   240
         TabIndex        =   5
         Top             =   1440
         Width           =   1800
      End
      Begin VB.OptionButton CursorTypeOpt 
         Caption         =   "adOpenDynamic"
         CausesValidation=   0   'False
         Height          =   255
         Index           =   2
         Left            =   240
         TabIndex        =   4
         Top             =   1080
         Width           =   1800
      End
      Begin VB.OptionButton CursorTypeOpt 
         Caption         =   "adOpenStatic"
         Height          =   255
         Index           =   1
         Left            =   240
         TabIndex        =   3
         Top             =   720
         Width           =   1800
      End
      Begin VB.OptionButton CursorTypeOpt 
         Caption         =   "adOpenForwardOnly"
         Height          =   255
         Index           =   0
         Left            =   240
         TabIndex        =   2
         Top             =   360
         Value           =   -1  'True
         Width           =   1800
      End
   End
   Begin VB.Label labelProperties 
      Caption         =   "Properties"
      Height          =   252
      Left            =   4080
      TabIndex        =   41
      Top             =   5160
      Width           =   1212
   End
   Begin VB.Label Label8 
      Caption         =   "Actual Recordset properties"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   7.47
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   120
      TabIndex        =   39
      Top             =   2880
      Width           =   3135
   End
   Begin VB.Label Label7 
      Caption         =   "Recordset.Supports(...)"
      Height          =   252
      Left            =   120
      TabIndex        =   25
      Top             =   5160
      Width           =   2172
   End
   Begin VB.Label labelCursorLocation 
      Caption         =   "labelCursorLocation"
      ForeColor       =   &H00FF0000&
      Height          =   255
      Left            =   2520
      TabIndex        =   24
      Top             =   4680
      Width           =   1335
   End
   Begin VB.Label labelLockType 
      Caption         =   "labelLockType"
      ForeColor       =   &H00FF0000&
      Height          =   255
      Left            =   2520
      TabIndex        =   23
      Top             =   4320
      Width           =   1335
   End
   Begin VB.Label labelCursorType 
      Caption         =   "labelCursorType"
      ForeColor       =   &H00FF0000&
      Height          =   255
      Left            =   2520
      TabIndex        =   22
      Top             =   3960
      Width           =   1335
   End
   Begin VB.Label Label6 
      Caption         =   "Actual LockType:"
      Height          =   255
      Left            =   120
      TabIndex        =   21
      Top             =   4320
      Width           =   2175
   End
   Begin VB.Label Label5 
      Caption         =   "Actual CursorLocation:"
      Height          =   255
      Left            =   120
      TabIndex        =   20
      Top             =   4680
      Width           =   2415
   End
   Begin VB.Label Label4 
      Caption         =   "Actual CursorType:"
      Height          =   255
      Left            =   120
      TabIndex        =   19
      Top             =   3960
      Width           =   2295
   End
   Begin VB.Label Label3 
      Caption         =   "Time to loop through entire Recordset with MoveNext:"
      Height          =   255
      Left            =   120
      TabIndex        =   18
      Top             =   3600
      Width           =   4575
   End
   Begin VB.Label Label2 
      Caption         =   "Time until Recordset is available [seconds]:"
      Height          =   255
      Left            =   120
      TabIndex        =   17
      Top             =   3240
      Width           =   4455
   End
   Begin VB.Line Line1 
      BorderWidth     =   3
      X1              =   120
      X2              =   8280
      Y1              =   2640
      Y2              =   2640
   End
   Begin VB.Label labelTime2 
      Caption         =   "labelTime2"
      ForeColor       =   &H00FF0000&
      Height          =   255
      Left            =   4920
      TabIndex        =   15
      Top             =   3600
      Width           =   1335
   End
   Begin VB.Label labelTime1 
      Caption         =   "labelTime1"
      ForeColor       =   &H00FF0000&
      Height          =   255
      Left            =   4920
      TabIndex        =   14
      Top             =   3240
      Width           =   1335
   End
   Begin VB.Label Label1 
      Caption         =   "Requested Recordset properties"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   7.47
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   3135
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
' cursortypes.vbp
Option Explicit

Dim cursor_type As ADODB.CursorTypeEnum
Dim lock_type As ADODB.LockTypeEnum
Dim cursor_location As ADODB.CursorLocationEnum
Dim conn As New Connection
Dim sq$

' connect to MySQL
Private Sub Form_Load()
  Dim options%
  options = 3 '+ 32
  If (options And 32) = 0 Then
    MsgBox "If you want to test dynamic server cursors, please add add 32 (enable dynamic cursor) to the options variable in Form_Load()!"
  End If

  Dim dataSource$, intSecurity$, userID$
  Dim db$
  Dim result&
  
  ' default settings for first attempt
  cursor_type = adOpenForwardOnly
  lock_type = adLockReadOnly
  cursor_location = adUseServer
  
  sq = "SELECT * FROM titles ORDER BY title"
  
  Set conn = New Connection
  conn.ConnectionString = "Provider=MSDASQL;" + _
    "DRIVER={MySQL ODBC 3.51 Driver};" + _
    "Server=localhost;UID=root;PWD=uranus;" + _
    "database=mylibrary;Option=" & options
  conn.Open
End Sub

' open Recordset, loop through it, close
Private Sub cmdOpen_Click()
  Dim rec As New Recordset
  Dim timerStart, dummy
  Dim cursorTypes, cursorLocks, cursorLocations
  Dim i&, j&, counter&
  cursorTypes = Array("ForwardOnly", "Keyset", "Dynamic", "Static")
  cursorLocks = Array("", "ReadOnly", "Pessimistic", "Optimistic", "BatchOptimistic")
  cursorLocations = Array("", "", "Server", "Client")
  
  ' open recordset
  Screen.MousePointer = vbHourglass
  timerStart = Timer
  rec.CursorLocation = cursor_location
  rec.Open sq, conn, cursor_type, lock_type
  
  ' show actual recordset properties
  labelTime1 = Timer - timerStart
  labelCursorType = cursorTypes(rec.CursorType)
  labelLockType = cursorLocks(rec.LockType)
  labelCursorLocation = cursorLocations(rec.CursorLocation)
  
  chkAddNew = SupportsCheck(rec, adAddNew)
  chkApprox = SupportsCheck(rec, adApproxPosition)
  chkBookmark = SupportsCheck(rec, adBookmark)
  chkDelete = SupportsCheck(rec, adDelete)
  chkFind = SupportsCheck(rec, adFind)
  chkHoldRecords = SupportsCheck(rec, adHoldRecords)
  chkIndex = SupportsCheck(rec, adIndex)
  chkMovePrev = SupportsCheck(rec, adMovePrevious)
  chkNotify = SupportsCheck(rec, adNotify)
  chkResync = SupportsCheck(rec, adResync)
  chkSeek = SupportsCheck(rec, adSeek)
  chkUpdate = SupportsCheck(rec, adUpdate)
  chkUpdateBatch = SupportsCheck(rec, adUpdateBatch)
  
  ' get Recordset properties, sort them, show them
  txtProperties = "": counter = 0
  Dim tmp$()
  ReDim tmp$(rec.Properties.Count - 1)
  Dim swap$
  For i = 0 To rec.Properties.Count - 1
    If Not (rec.Properties(i).Attributes And adPropNotSupported) Then
      tmp$(counter) = rec.Properties(i).Name & ": " _
        & rec.Properties(i).Value
      counter = counter + 1
    End If
  Next i
  For i = 1 To counter - 1
    For j = 0 To i
      If tmp(j) > tmp(i) Then
        swap = tmp(i)
        tmp(i) = tmp(j)
        tmp(j) = swap
      End If
    Next
  Next
  For i = 0 To counter - 1
    txtProperties = txtProperties + tmp(i) + vbCrLf
  Next
  labelProperties = counter & " Properties"
  
  ' loop through Recordset with MoveNext
  timerStart = Timer
  Do While Not rec.EOF
    ' make sure that some data is really read
    If rec!titleID > 3 Then dummy = dummy + 1
    rec.MoveNext
  Loop
  labelTime2 = Timer - timerStart
  Screen.MousePointer = vbNormal
  rec.Close
  Set rec = Nothing
End Sub

Private Function SupportsCheck(rec As Recordset, copt As CursorOptionEnum)
  If rec.Supports(copt) Then
    SupportsCheck = vbChecked
  Else
    SupportsCheck = 0
  End If
End Function

' choose recordset type
Private Sub CursorTypeOpt_Click(Index As Integer)
  Select Case Index
  Case 0: cursor_type = adOpenForwardOnly
  Case 1: cursor_type = adOpenStatic
  Case 2: cursor_type = adOpenDynamic
  Case 3: cursor_type = adOpenKeyset
  End Select
End Sub
Private Sub LockTypeOpt_Click(Index As Integer)
  Select Case Index
  Case 0: lock_type = adLockReadOnly
  Case 1: lock_type = adLockPessimistic
  Case 2: lock_type = adLockOptimistic
  Case 3: lock_type = adLockBatchOptimistic
  End Select
End Sub
Private Sub CursorLocationOpt_Click(Index As Integer)
  Select Case Index
  Case 0: cursor_location = adUseServer
  Case 1: cursor_location = adUseClient
  End Select
End Sub

' resize textbox
Private Sub Form_Resize()
  On Error Resume Next
  With txtProperties
    .Move .Left, .Top, ScaleWidth - .Left - 60, ScaleHeight - 60 - .Top
  End With
End Sub


' the end
Private Sub cmdEnd_Click()
  Unload Me
End Sub
Private Sub Form_Unload(Cancel As Integer)
  conn.Close
  Set conn = Nothing
  sq = ""
  Unload Me
End Sub



