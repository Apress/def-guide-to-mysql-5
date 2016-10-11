VERSION 5.00
Object = "{0ECD9B60-23AA-11D0-B351-00A0C9055D8E}#6.0#0"; "MSHFLXGD.OCX"
Begin VB.Form Form1 
   Caption         =   "FlexGrid"
   ClientHeight    =   2548
   ClientLeft      =   52
   ClientTop       =   338
   ClientWidth     =   4069
   LinkTopic       =   "Form1"
   ScaleHeight     =   2548
   ScaleWidth      =   4069
   StartUpPosition =   3  'Windows-Standard
   Begin MSHierarchicalFlexGridLib.MSHFlexGrid MSHFlexGrid1 
      Bindings        =   "Form1.frx":0000
      Height          =   1452
      Left            =   120
      TabIndex        =   1
      Top             =   960
      Width           =   3852
      _ExtentX        =   6805
      _ExtentY        =   2564
      _Version        =   393216
      Cols            =   7
      AllowUserResizing=   1
      DataMember      =   "publishers"
      _NumberOfBands  =   3
      _Band(0).Cols   =   3
      _Band(0)._NumMapCols=   2
      _Band(0)._MapCol(0)._Name=   "publName"
      _Band(0)._MapCol(0)._RSIndex=   0
      _Band(0)._MapCol(1)._Name=   "publID"
      _Band(0)._MapCol(1)._RSIndex=   1
      _Band(0)._MapCol(1)._Alignment=   7
      _Band(1).BandIndent=   1
      _Band(1).Cols   =   2
      _Band(1)._ParentBand=   0
      _Band(1)._NumMapCols=   2
      _Band(1)._MapCol(0)._Name=   "title"
      _Band(1)._MapCol(0)._RSIndex=   0
      _Band(1)._MapCol(1)._Name=   "publID"
      _Band(1)._MapCol(1)._RSIndex=   1
      _Band(1)._MapCol(1)._Alignment=   7
      _Band(2).BandIndent=   2
      _Band(2).Cols   =   2
      _Band(2)._ParentBand=   1
      _Band(2)._NumMapCols=   2
      _Band(2)._MapCol(0)._Name=   "authName"
      _Band(2)._MapCol(0)._RSIndex=   0
      _Band(2)._MapCol(1)._Name=   "titleID"
      _Band(2)._MapCol(1)._RSIndex=   1
      _Band(2)._MapCol(1)._Alignment=   7
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

' update the connection properties for de.dsr (data environment)!
' this example assumes there is a working DSN named mysql-mylibrary

Private Sub Form_Load()
  MSHFlexGrid1.Refresh
End Sub

Private Sub Form_Resize()
  On Error Resume Next
  With MSHFlexGrid1
    .Move .Left, .Top, ScaleWidth - 2 * .Left, ScaleHeight - .Left - .Top
  End With
End Sub
