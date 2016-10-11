VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Connection Test"
   ClientHeight    =   1755
   ClientLeft      =   52
   ClientTop       =   338
   ClientWidth     =   3497
   LinkTopic       =   "Form1"
   ScaleHeight     =   1755
   ScaleWidth      =   3497
   StartUpPosition =   3  'Windows-Standard
   Begin VB.CommandButton Command1 
      Caption         =   "Connect to MySQL"
      Height          =   372
      Left            =   240
      TabIndex        =   0
      Top             =   1200
      Width           =   2292
   End
   Begin VB.Label Label1 
      Caption         =   $"Form1.frx":0000
      Height          =   852
      Left            =   120
      TabIndex        =   1
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

Dim conn As Connection
Dim rec As Recordset

Private Sub Command1_Click()
  Set conn = New Connection
  ' conn.ConnectionString = "DSN=mysql-mylibrary;UID=root;PWD=xxx"
  conn.ConnectionString = "Provider=MSDASQL;" + _
    "DRIVER={MySQL ODBC 3.51 Driver};" + _
    "Server=localhost;UID=root;PWD=uranus;" + _
    "database=mylibrary;Option=16387"
  conn.Open
  
  Set rec = New Recordset
  rec.CursorLocation = adUseClient
  rec.Open "SELECT * FROM titles", conn
      
  Debug.Print conn.ConnectionString
  Dim p As Property
  For Each p In conn.Properties
    Debug.Print p.Name & " = " & p.Value
  Next
End Sub
