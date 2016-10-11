VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   2678
   ClientLeft      =   52
   ClientTop       =   390
   ClientWidth     =   4056
   LinkTopic       =   "Form1"
   ScaleHeight     =   2678
   ScaleWidth      =   4056
   StartUpPosition =   3  'Windows-Standard
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
' this program converts Microsoft SQL Server databases to MySQL databases

' (c) 2001-2005 Michael Kofler
'     http://www.kofler.cc/mysql
'     mssql2mysql-at-kofler.cc

' LICENSE: GPL (Gnu Public License)
' VERSION: 0.11 (Mar 1st 2005)
'
' HISTORY:
' 0.01 (Jan. 18 2001): initial version
' 0.02 (June 23 2001): better handling of decimal numbers
'   by <dave.whitla-at-ocean.net.au>
' 0.03 (August 7 2001): compatibility with Office 97
'   by <DaveMeaker-at-angelshade.com>
'   (uncomment Replace function at the end of the script!)
' 0.04 (September 30 2001): slightly faster (ideas by
'    janivar-at-acos.no)
' 0.05 (April 8 2002): compatible with MyODBC 3.51
'    (set variable MyODBCVersion accordingly!)
'    thanks to Silvio Iaccarino
' 0.05a (October 17 2002): support for BIGINT
'    thanks to Ugo Gioia
' 0.06 (December 18 2002): support for adBinary (thanks to Roberto Alicata)
'    changed handling of TIMESTAMP (Michael Kofler):
'      TIMESTAMP (MSSQL) --> TINYBLOB (MySQL)
' 0.07 (Jan. 27th 2003): support no-standard ports for MySQL
' 0.08 (Apr. 30th 2003): Boolean now converts to 1/0 instead of -1/0
'      for True/False (Michael Kofler)
' 0.09 (Aug. 19th 2003): better GUID conversion (Hermann Wiesner)
' 0.10 (Nov. 12th 2003): better handling of table and field names
'      in function MySQLName (Carlo)
' 0.11 (Mar. 1st 2005): needs MySQL 4.1 or higher!
'      new functions: - supports myisam and innodb tables
'                     - per default all text columns are now created with character
'                       set utf8and collation utf8_general_ci; you may choose another
'                       charset + collation (constants CHARSET and COLLATION)

' USEAGE:
' 1) copy this code into a new VBA 6 module
'    (i.e. start Excel 2000 or Word 2000 or another
'     program with VBA editor, hit Alt+F11, execute
'     Insert|Module, insert code)
'    OR copy code into an empty form of a new VB6 project
'
' 2) change the constants at the beginning of the code,
' 3) hit F5 and execute Main()
'    the program now connects to Microsoft SQL Server
'    and converts the database; the resulting SQL commands
'    are either saved in an ASCII file or executed immediately

' FUNCTION:
' converts both schema (tables and indices) and
' data (numbers, strings, dates etc.)
' handles table and column names which are not legal in MySQL (see MySQLName())

' LIMITATIONS:
' no foreign keys
' no SPs, no triggers (MSSQL syntax incompatible to MySQL)
' no views
' no user defined data types (not yet supported by MySQL)
' AUTO_INCREMENTs: MySQL does not support tables with more
'   than one AUTO_INCREMENT column; the AUTO_INCREMENT column
'   must also be a key column; the converter does not check this,
'   so use MSSQL to add an index to the AUTO_INCREMENT column
'   before starting the conversion
' no privileges/access infos (the idea of logins/users in M$ SQL Server
'     is incompatible with user/group/database/table/column
'     privileges of MySQL)
' cannot handle ADO type adFileTime yet
' GUIDs not tested
' fairly slow and no visible feedback during conversion process
'   for example, it takes 80 seconds to convert Northwind (2.8 MB data)
'   with M$SQL running on PII 350 (CPU=0) and this script running in
'   Excel 2000 on PII 400 (CPU=100); unfortunately, compiling the program
'   with VB6 does not make it any faster
'   tip: test with MAX_RECORDS = 10 first to see if it works for you at all

' INTERNALS:
' method:   read database schema using DMO
'           read data using a ADO recordset

' NECESSARY LIBRARIES:
'   ADODB          (tested with 2.8, should also run with all versions >=2.1)
'   Connector/ODBC (testet with 3.51.11, should also run with older versions;
'                   if you use MySQL server >= 4.1,
'                   you MUST use Connector/ODBC >= 3.51.10!!!)
'   SQLDMO (tested with the version provided by M$ SQL Server 2000)
'   SCRIPTING

Option Explicit
Option Compare Text

' -------------- change these constants before use!

                                  'M$ SQL Server
Const MSSQL_SECURE_LOGIN = True   'login type (True for NT security)
Const MSSQL_LOGIN_NAME = ""       'login name (for NT security use "" here)
Const MSSQL_PASSWORD = ""         'password   (for NT security use "" here)
Const MSSQL_HOST = "(local)"      'hostname of M$ SQL Server; if localhost: use "(local)"
Const MSSQL_DB_NAME = "Northwind" 'database name

Const OUTPUT_TO_FILE = 0          '1 --> write file (latin1 encoding);
                                  '0 --> connect to MySQL, execute SQL commands directly
                                  
                                  'output file (only needed if OUTPUT_TO_FILE=1)
Const OUTPUT_FILENAME = "c:\export.sql"

                                  'connect to MySQL (only needed if OUTPUT_TO_FILE=0)
Const MYSQL_USER_NAME = "root"    'login name
Const MYSQL_PASSWORD = "uranus"   'password
Const MYSQL_HOST = "192.168.80.128" 'if localhost: use "localhost"
Const MYSQL_PORT = 3306           'change if you use another port
Const MyODBCVersion = "MySQL ODBC 3.51 Driver"
                                  'for MyODBC 2.51.* use "MySQL"

Const NEW_DB_NAME = ""            'name of new MySQL database ("" if same as M$SQL db name)
                                  'conversion options
Const DROP_DATABASE = True        'begin with DROP dbname?
Const MAX_RECORDS = 0             'max. nr of records per table (0 for all records, n for testing purposes)
Const VARCHAR_MAX = 255           'max. nr of characters in VARCHAR
                                  '255 for MySQL <=5.0.2
                                  'ca. 32000 for MySQL >= 5.0.3 (depends on char. set, max. 65535 bytes)
Const TABLE_ENGINE = "InnoDB"     'MyISAM or InnoDB
Const CHARSET = "utf8"            'character set for all text columns
Const COLLATION = ""              'collation; leave empty if you want to use the default collation for
                                  'the specified character set

' ----------------------------- don't change below here (unless you know what you are doing)

Const SQLDMOIndex_DRIPrimaryKey = 2048
Const SQLDMOIndex_Unique = 2
Const adEmpty = 0
Const adTinyInt = 16
Const adSmallInt = 2
Const adInteger = 3
Const adBigInt = 20
Const adUnsignedTinyInt = 17
Const adUnsignedSmallInt = 18
Const adUnsignedInt = 19
Const adUnsignedBigInt = 21
Const adSingle = 4
Const adDouble = 5
Const adCurrency = 6
Const adDecimal = 14
Const adNumeric = 131
Const adBoolean = 11
Const adError = 10
Const adUserDefined = 132
Const adVariant = 12
Const adIDispatch = 9
Const adIUnknown = 13
Const adGUID = 72
Const adDate = 7
Const adDBDate = 133
Const adDBTime = 134
Const adDBTimeStamp = 135
Const adBSTR = 8
Const adChar = 129
Const adVarChar = 200
Const adLongVarChar = 201
Const adWChar = 130
Const adVarWChar = 202
Const adLongVarWChar = 203
Const adBinary = 128
Const adVarBinary = 204
Const adLongVarBinary = 205
Const adChapter = 136
Const adFileTime = 64
Const adPropVariant = 138
Const adVarNumeric = 139
Const adArray = &H2000

Public dmoApplic 'As New SQLDMO.Application  'SQLDMO Application object
Public dmoSrv    'As New SQLDMO.SQLServer    'SQLDMO Server object
Public mssqlConn 'As New Connection          'ADO Connection to M$ SQL Server
Public mysqlConn 'As New Connection          'ADO Connection to MySQL
Public fso       'As Scripting.FileSystemObject
Public fileout   'AS FSO.TextStream

Public Sub Main()
  Set dmoApplic = CreateObject("SQLDMO.Application")
  Set dmoSrv = CreateObject("SQLDMO.SQLServer")
  Set mssqlConn = CreateObject("ADODB.Connection")
  Set mysqlConn = CreateObject("ADODB.Connection")
  Set fso = CreateObject("Scripting.FileSystemObject")
  ConnectToDatabases
  ConvertDatabase
  MsgBox "done"
End Sub

' connect to M$ SQL Server and MySQL
Private Sub ConnectToDatabases()
  dmoSrv.LoginTimeout = 10
  On Error Resume Next
  
  ' DMO connection to M$ SQL Server
  If MSSQL_SECURE_LOGIN Then
    dmoSrv.LoginSecure = True
    dmoSrv.Connect MSSQL_HOST
  Else
    dmoSrv.LoginSecure = False
    dmoSrv.Connect MSSQL_HOST, MSSQL_LOGIN_NAME, MSSQL_PASSWORD
  End If
  If Err Then
    MsgBox "Sorry, cannot connect to M$ SQL Server. " & _
      "Please edit the MSSQL constats at the beginning " & _
      "of the code." & vbCrLf & vbCrLf & Error
    End
  End If
  
  ' ADO connection to M$ SQL Server
  Dim tmpCStr$
  tmpCStr = _
    "Provider=SQLOLEDB;" & _
    "Data Source=" & MSSQL_HOST & ";" & _
    "Initial Catalog=" & MSSQL_DB_NAME & ";"
  If MSSQL_SECURE_LOGIN Then
    tmpCStr = tmpCStr & "Integrated Security=SSPI"
  Else
    tmpCStr = tmpCStr & _
      "User ID=" & MSSQL_LOGIN_NAME & ";" & _
      "Password=" & MSSQL_PASSWORD
  End If
  mssqlConn.ConnectionString = tmpCStr
  mssqlConn.Open
  If Err Then
    MsgBox "Sorry, cannot connect to M$ SQL Server. " & _
      "Please edit the MSSQL constats at the beginning " & _
      "of the code." & vbCrLf & vbCrLf & Error
    End
  End If
  
  ' ADO connection to MySQL or open output file
  If (OUTPUT_TO_FILE = 0) Then
    mysqlConn.ConnectionString = _
      "Provider=MSDASQL;" & _
      "Driver=" & MyODBCVersion & ";" & _
      "Server=" & MYSQL_HOST & ";" & _
      "UID=" & MYSQL_USER_NAME & ";" & _
      "PWD=" & MYSQL_PASSWORD & ";" & _
      "Port=" & MYSQL_PORT
    mysqlConn.Open
    If Err Then
      MsgBox "Sorry, cannot connect to MySQL. " & _
        "Please edit the MYSQL constats at the beginning " & _
        "of the code." & vbCrLf & vbCrLf & Error
      End
    End If
  Else
    Set fileout = fso.CreateTextFile(OUTPUT_FILENAME, Overwrite:=True)
  End If
End Sub

Private Sub ConvertDatabase()
  ' copy database schema
  Dim dmoDB 'As SQLDMO.Database
  Set dmoDB = dmoSrv.Databases(MSSQL_DB_NAME)
  DBDefinition dmoDB
  ' copy data
  CopyDB dmoDB
End Sub

' build SQL code to define one column
' ColDefinition$(col As SQLDMO.Column)
Function ColDefinition$(col)
  Dim cdef$
  cdef = MySQLName(col.Name) & " " & DataType(col)
  If col.Default <> "" Then
    cdef = cdef & " DEFAULT " & col.Default
  End If
  If col.AllowNulls Then
    cdef = cdef & " NULL"
  Else
    cdef = cdef & " NOT NULL"
  End If
  If col.Identity Then
    cdef = cdef & " AUTO_INCREMENT"
  End If
  ColDefinition = cdef
End Function

' datatype transition M$ SQL Server --> MySQL
' DataType$(col As SQLDMO.Column)
Function DataType$(col)
  Dim oldtype$, length&, precision&, scal&
  Dim newtype$
  
  oldtype = col.PhysicalDatatype
  length = col.length
  precision = col.NumericPrecision
  scal = col.NumericScale
  If LCase(oldtype) = "money" Then
    precision = 19
    scal = 4
  ElseIf LCase(oldtype) = "smallmoney" Then
    precision = 10
    scal = 4
  End If
  
  Select Case LCase(oldtype)
  
  ' integers
  Case "bit", "tinyint"
    newtype = "TINYINT"
  Case "smallint"
    newtype = "SMALLINT"
  Case "int"
    newtype = "INT"
  Case "bigint"
    newtype = "BIGINT"
  
  ' floating points
  Case "float"
    newtype = "DOUBLE"
  Case "real"
    newtype = "FLOAT"
  Case "decimal", "numeric", "money", "smallmoney"
    newtype = "DECIMAL(" & precision & ", " & scal & ")"
  
  ' strings
  Case "char", "nchar"
    If length < 255 Then
      newtype = "CHAR(" & length & ")"
    Else
      newtype = "TEXT"
    End If
  Case "varchar", "nvarchar"
    If length < VARCHAR_MAX Then
      newtype = "VARCHAR(" & length & ")"
    Else
      newtype = "TEXT"
    End If
  Case "text", "ntext"
    newtype = "LONGTEXT"
    
  ' date/time
  Case "datetime", "smalldatetime"
    newtype = "DATETIME"
  Case "timestamp"
    newtype = "TINYBLOB"
    
  ' binary and other
  Case "uniqueidentifier"
    newtype = "TINYBLOB"
  Case "binary", "varbinary"
    newtype = "BLOB"
  Case "image"
    newtype = "LONGBLOB"
  
  Case Else
    ' unknown data type, not supported
    Stop
  End Select
  
  DataType = newtype
End Function

' IndexDefinition$(tbl As SQLDMO.Table, idx As SQLDMO.Index)
Function IndexDefinition$(tbl, idx)
  Dim i&
  Dim tmp$
  Dim col 'As SQLDMO.Column
  ' don't deal with system indices (used i.e. to ensure ref. integr.)
  If Left$(idx.Name, 1) = "_" Then Exit Function
  ' index type (very incomplete !!!)
  If idx.Type And SQLDMOIndex_DRIPrimaryKey Then
    tmp = tmp & "PRIMARY KEY"
  ElseIf idx.Type And SQLDMOIndex_Unique Then
    tmp = tmp & "UNIQUE " & MySQLName(idx.Name)
  Else
    tmp = tmp & "INDEX " & MySQLName(idx.Name)
  End If
  ' index columns
  tmp = tmp & "("
  For i = 1 To idx.ListIndexedColumns.Count
    Set col = idx.ListIndexedColumns(i)
    tmp = tmp & MySQLName(col.Name)
    ' specify index length
    If Right$(DataType(col), 4) = "BLOB" Or Right$(DataType(col), 4) = "TEXT" Then
      tmp = tmp & "(" & IIf(col.length < 255, col.length, 255) & ")"
    End If
    ' seperate, if more than one index column
    If i < idx.ListIndexedColumns.Count Then tmp = tmp & ","
  Next
  tmp = tmp & ")"
  IndexDefinition = tmp
End Function

' build SQL code to define one table
' TableDefinition$(tbl As SQLDMO.Table)
Function TableDefinition$(tbl)
  Dim i&
  Dim tmp$, ixdef$
  ' table
  tmp = "CREATE TABLE " & _
        NewDBName(tbl.Parent) & "." & MySQLName(tbl.Name) & vbCrLf & "("
  For i = 1 To tbl.Columns.Count
    tmp = tmp & ColDefinition(tbl.Columns(i))
    If i < tbl.Columns.Count Then
      tmp = tmp & ", " & vbCrLf
    End If
  Next
  ' indices
  For i = 1 To tbl.Indexes.Count
    ixdef = IndexDefinition(tbl, tbl.Indexes(i))
    If ixdef <> "" Then
      tmp = tmp & ", " & vbCrLf & ixdef
    End If
  Next
  tmp = tmp & ")"
  ' engine
  tmp = tmp & " ENGINE " & TABLE_ENGINE
  ' characterset
  tmp = tmp & " CHARACTER SET " & CHARSET
  ' collation
  If COLLATION <> "" Then
    tmp = tmp & " COLLATION " & COLLATION
  End If
  TableDefinition = tmp
End Function

' build SQL code to define database (all tables)
' DBDefinition(db As SQLDMO.Database)
Sub DBDefinition(db)
  Dim i&
  Dim sql, dbname$
  dbname = NewDBName(db)
  If DROP_DATABASE Then
    sql = "DROP DATABASE IF EXISTS " & dbname
    ExecuteSQL sql
  End If
  sql = "CREATE DATABASE " & dbname
  ExecuteSQL sql
  For i = 1 To db.Tables.Count
    If Not db.Tables(i).SystemObject Then
      sql = TableDefinition(db.Tables(i))
      ExecuteSQL sql
    End If
  Next
End Sub

' copy content of all M$ SQL Server tables to new MySQL database
' CopyDB(msdb As SQLDMO.Database)
Sub CopyDB(msdb)
  Dim i&
  Dim tmp$
  ExecuteSQL "USE " & NewDBName(msdb)
  For i = 1 To msdb.Tables.Count
    If Not msdb.Tables(i).SystemObject Then
      CopyTable msdb.Tables(i)
    End If
  Next
End Sub

' copy content of one table from M$ SQL Server to MySQL
' CopyTable(mstable As SQLDMO.Table)
Sub CopyTable(mstable)
  Dim rec ' As Recordset
  Dim sqlInsert$, sqlValues$
  Dim i&, recordCounter&
  Set rec = CreateObject("ADODB.Recordset")
  rec.Open "SELECT * FROM [" & mstable.Name & "]", mssqlConn
  ' build beginning statement of SQL INSERT command
  ' for example: INSERT INTO tablename (column1, column2)
  sqlInsert = "INSERT INTO " & MySQLName(mstable.Name) & " ("
  For i = 0 To rec.Fields.Count - 1
    sqlInsert = sqlInsert & MySQLName(rec.Fields(i).Name)
    If i <> rec.Fields.Count - 1 Then
      sqlInsert = sqlInsert & ", "
    End If
  Next
  sqlInsert = sqlInsert & ") "
  ' for each recordset in M$SS table: build sql statement
  Do While Not rec.EOF
    sqlValues = ""
    For i = 0 To rec.Fields.Count - 1
      sqlValues = sqlValues & DataValue(rec.Fields(i))
      If i <> rec.Fields.Count - 1 Then
        sqlValues = sqlValues & ", "
      End If
    Next
    ExecuteSQL sqlInsert & " VALUES(" & sqlValues & ")"
    rec.MoveNext
    ' counter
    recordCounter = recordCounter + 1
    If MAX_RECORDS <> 0 Then
      If recordCounter >= MAX_RECORDS Then Exit Do
    End If
  Loop
End Sub

' data transition M$ SQL Server --> MySQL
' DataValue$(fld As ADO.Field)
Function DataValue$(fld)
  If IsNull(fld.Value) Then
    DataValue = "NULL"
  Else

    Select Case fld.Type
    
    ' integer numbers
    Case adBigInt, adInteger, adSmallInt, adTinyInt, adUnsignedBigInt, adUnsignedInt, adUnsignedSmallInt, adUnsignedTinyInt
      DataValue = fld.Value
    
    ' decimal numbers
    Case adCurrency, adDecimal, adDouble, adNumeric, adSingle, adVarNumeric
      DataValue = Str(fld.Value)
      If Not InStr(DataValue, ".") > 0 Then
        DataValue = DataValue & ".0"
      End If
      
    ' boolean
    Case adBoolean
      DataValue = IIf(fld.Value, 1, 0)
      
    ' date, time
    Case adDate, adDBDate, adDBTime
      DataValue = Format(fld.Value, "'yyyy-mm-dd Hh:Nn:Ss'")
    Case adDBTimeStamp
      DataValue = Format(fld.Value, "yyyymmddHhNnSs")
    Case adFileTime
      ' todo
      Beep
      Stop
      
    ' strings
    Case adBSTR, adChar, adLongVarChar, adVarChar, adLongVarWChar, adVarWChar, adWChar
      DataValue = "'" & Quote(fld.Value) & "'"
    
    ' binary and other
    Case adGUID
      DataValue = HexCodeGUID(fld.Value)
    Case adLongVarBinary, adVarBinary
      DataValue = HexCode(fld.Value)
    
    End Select
  End If
End Function

' converts a Byte-array into a hex string
' HexCode$(bytedata() As Byte)
Function HexCode(bytedata)
  Dim i&
  Dim tmp$
  tmp = ""
  For i = LBound(bytedata) To UBound(bytedata)
    If bytedata(i) <= 15 Then
      tmp = tmp + "0" + Hex(bytedata(i))
    Else
      tmp = tmp + Hex(bytedata(i))
    End If
  Next
  HexCode = "0x" + tmp
End Function

' converts a String into a hex string
' HexCode$(bytedata() As Byte)
Function HexCodeStr(bytedata)
  Dim i&, b&
  Dim tmp$
  tmp = ""
  For i = 1 To LenB(bytedata)
    b = AscB(MidB(bytedata, i, 1))
    If b <= 15 Then
      tmp = tmp + "0" + Hex(b)
    Else
      tmp = tmp + Hex(b)
    End If
  Next
  HexCodeStr = "0x" + tmp
End Function

' returns name of new database
' NewDBName$(db As SQLDMO.Database)
Function NewDBName$(db)
  If NEW_DB_NAME = "" Then
    NewDBName = db.Name
  Else
    NewDBName = NEW_DB_NAME
  End If
End Function

' quote ' " and \; replace chr(0) by \0
Function Quote(tmp)
  tmp = Replace(tmp, "\", "\\")
  tmp = Replace(tmp, """", "\""")
  tmp = Replace(tmp, "'", "\'")
  Quote = Replace(tmp, Chr(0), "\0")
End Function

' to translate MSSQL names to legal MySQL names
' replace blank, -, ( and ) by '_'
Function MySQLName(tmp)
  tmp = Replace(tmp, " ", "_")
  tmp = Replace(tmp, "-", "_")
  tmp = Replace(tmp, "(", "_")
  MySQLName = "`" & Replace(tmp, ")", "_") & "`"
End Function

' either execute SQL command or write it into file
Function ExecuteSQL(sql)
  If OUTPUT_TO_FILE Then
    fileout.WriteLine sql & ";"
    If Left$(sql, 6) <> "INSERT" Then
      fileout.WriteLine
    End If
  Else
    mysqlConn.Execute sql
  End If
End Function

' this event procedures starts the converter if it is run as a VB6 programm
Private Sub Form_Load()
  Main
  End
End Sub

' converts a GUID string into a hex string without format
Function HexCodeGUID(bytedata)
  Dim tmp$
  If Len(bytedata) = 38 Then
    tmp = Mid(bytedata, 2, 8) + Mid(bytedata, 11, 4) + Mid(bytedata, 16, 4) _
        + Mid(bytedata, 21, 4) + Mid(bytedata, 26, 12)
  Else
    tmp = "00"
  End If
  HexCodeGUID = "0x" + tmp
End Function


' uncomment the following lines if you are using Office 97,
' which does not have the Replace function include; please
' note that this Replace function is much slower than the
' built-in version in Office 2000/VB6
'
' to replace all occurrences of a string within a string
' Function Replace(tmp, fromStr, toStr)
'     Dim leftOff&
'     Dim pos&
'     leftOff = 1
'     Do While InStr$(leftOff, tmp, fromStr) > 0
'         pos = InStr$(leftOff, tmp, fromStr)
'         tmp = Left$(tmp, pos - 1) + toStr + Mid$(tmp, pos + Len(fromStr), Len(tmp))
'         leftOff = pos + Len(fromStr) + 1
'     Loop
'     Replace = tmp
' End Function




