VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   1677
   ClientLeft      =   52
   ClientTop       =   338
   ClientWidth     =   3614
   LinkTopic       =   "Form1"
   ScaleHeight     =   1677
   ScaleWidth      =   3614
   StartUpPosition =   3  'Windows-Standard
   Begin VB.CommandButton Command1 
      Caption         =   "Connect to MySQL"
      Height          =   372
      Left            =   480
      TabIndex        =   1
      Top             =   1200
      Width           =   2292
   End
   Begin VB.Label Label1 
      Caption         =   "To use this program, you have to change the parameters of the Connection object in the DataEnvironment."
      Height          =   732
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   3252
      WordWrap        =   -1  'True
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
' update de.dsr!
' this example assumes there is a working DSN named mysql-mylibrary

Private Sub Command1_Click()
  Dim rec As Recordset
  Set rec = New Recordset
  If DE.Conn.State = adStateClosed Then
    DE.Conn.Open
  End If
  rec.Open "select * from titles", DE.Conn
  
  Stop
End Sub
