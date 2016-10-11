VERSION 5.00
Begin {C0E45035-5775-11D0-B388-00A0C9055D8E} DE 
   ClientHeight    =   6097
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   9932
   _ExtentX        =   17516
   _ExtentY        =   10759
   FolderFlags     =   1
   TypeLibGuid     =   "{87CC37CE-9621-4F72-8BE1-8884B08AF6C6}"
   TypeInfoGuid    =   "{6838B8B6-477B-44F4-8DC4-E15785E79DDB}"
   TypeInfoCookie  =   0
   Version         =   4
   NumConnections  =   1
   BeginProperty Connection1 
      ConnectionName  =   "Conn"
      ConnDispId      =   1001
      SourceOfData    =   3
      ConnectionSource=   "Provider=MSDASQL.1;Persist Security Info=False;Data Source=mysql-mylibrary"
      Expanded        =   -1  'True
      QuoteChar       =   96
      SeparatorChar   =   46
   EndProperty
   NumRecordsets   =   4
   BeginProperty Recordset1 
      CommandName     =   "Command1"
      CommDispId      =   1002
      RsDispId        =   1006
      CommandText     =   $"DE.dsx":0000
      ActiveConnectionName=   "Conn"
      CommandType     =   1
      IsRSReturning   =   -1  'True
      NumFields       =   2
      BeginProperty Field1 
         Precision       =   0
         Size            =   40
         Scale           =   0
         Type            =   200
         Name            =   "title"
         Caption         =   "title"
      EndProperty
      BeginProperty Field2 
         Precision       =   0
         Size            =   18
         Scale           =   0
         Type            =   200
         Name            =   "authName"
         Caption         =   "authName"
      EndProperty
      NumGroups       =   0
      ParamCount      =   0
      RelationCount   =   0
      AggregateCount  =   0
   EndProperty
   BeginProperty Recordset2 
      CommandName     =   "publishers"
      CommDispId      =   1007
      RsDispId        =   1013
      CommandText     =   "SELECT publName, publID FROM publishers ORDER BY publName"
      ActiveConnectionName=   "Conn"
      CommandType     =   1
      Expanded        =   -1  'True
      IsRSReturning   =   -1  'True
      NumFields       =   2
      BeginProperty Field1 
         Precision       =   0
         Size            =   21
         Scale           =   0
         Type            =   200
         Name            =   "publName"
         Caption         =   "publName"
      EndProperty
      BeginProperty Field2 
         Precision       =   2
         Size            =   4
         Scale           =   0
         Type            =   3
         Name            =   "publID"
         Caption         =   "publID"
      EndProperty
      NumGroups       =   0
      ParamCount      =   0
      RelationCount   =   0
      AggregateCount  =   0
   EndProperty
   BeginProperty Recordset3 
      CommandName     =   "Titles"
      CommDispId      =   -1
      RsDispId        =   -1
      CommandText     =   "SELECT title, publID, titleID FROM titles ORDER BY title"
      ActiveConnectionName=   "Conn"
      CommandType     =   1
      RelateToParent  =   -1  'True
      ParentCommandName=   "publishers"
      Expanded        =   -1  'True
      IsRSReturning   =   -1  'True
      NumFields       =   3
      BeginProperty Field1 
         Precision       =   0
         Size            =   40
         Scale           =   0
         Type            =   200
         Name            =   "title"
         Caption         =   "title"
      EndProperty
      BeginProperty Field2 
         Precision       =   2
         Size            =   4
         Scale           =   0
         Type            =   3
         Name            =   "publID"
         Caption         =   "publID"
      EndProperty
      BeginProperty Field3 
         Precision       =   2
         Size            =   4
         Scale           =   0
         Type            =   3
         Name            =   "titleID"
         Caption         =   "titleID"
      EndProperty
      NumGroups       =   0
      ParamCount      =   0
      RelationCount   =   1
      BeginProperty Relation1 
         ParentField     =   "publID"
         ChildField      =   "publID"
         ParentType      =   0
         ChildType       =   0
      EndProperty
      AggregateCount  =   0
   EndProperty
   BeginProperty Recordset4 
      CommandName     =   "authors"
      CommDispId      =   -1
      RsDispId        =   -1
      CommandText     =   $"DE.dsx":00AD
      ActiveConnectionName=   "Conn"
      CommandType     =   1
      RelateToParent  =   -1  'True
      ParentCommandName=   "Titles"
      Expanded        =   -1  'True
      IsRSReturning   =   -1  'True
      NumFields       =   2
      BeginProperty Field1 
         Precision       =   0
         Size            =   18
         Scale           =   0
         Type            =   129
         Name            =   "authName"
         Caption         =   "authName"
      EndProperty
      BeginProperty Field2 
         Precision       =   4
         Size            =   4
         Scale           =   0
         Type            =   3
         Name            =   "titleID"
         Caption         =   "titleID"
      EndProperty
      NumGroups       =   0
      ParamCount      =   0
      RelationCount   =   1
      BeginProperty Relation1 
         ParentField     =   "titleID"
         ChildField      =   "titleID"
         ParentType      =   0
         ChildType       =   0
      EndProperty
      AggregateCount  =   0
   EndProperty
End
Attribute VB_Name = "DE"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Connection1_InfoMessage(ByVal pError As ADODB.Error, adStatus As ADODB.EventStatusEnum, ByVal pConnection As ADODB.Connection)

End Sub
