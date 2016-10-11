Option Strict On
Imports MySql.Data.MySqlClient

Public Class Form1
  Inherits System.Windows.Forms.Form

#Region " Windows Form Designer generated code "

  Public Sub New()
    MyBase.New()

    'This call is required by the Windows Form Designer.
    InitializeComponent()

    'Add any initialization after the InitializeComponent() call

  End Sub

  'Form overrides dispose to clean up the component list.
  Protected Overloads Overrides Sub Dispose(ByVal disposing As Boolean)
    If disposing Then
      If Not (components Is Nothing) Then
        components.Dispose()
      End If
    End If
    MyBase.Dispose(disposing)
  End Sub

  'Required by the Windows Form Designer
  Private components As System.ComponentModel.IContainer

  'NOTE: The following procedure is required by the Windows Form Designer
  'It can be modified using the Windows Form Designer.  
  'Do not modify it using the code editor.
  Friend WithEvents ComboBox1 As System.Windows.Forms.ComboBox
  Friend WithEvents DataGrid1 As System.Windows.Forms.DataGrid
  <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
    Me.ComboBox1 = New System.Windows.Forms.ComboBox
    Me.DataGrid1 = New System.Windows.Forms.DataGrid
    CType(Me.DataGrid1, System.ComponentModel.ISupportInitialize).BeginInit()
    Me.SuspendLayout()
    '
    'ComboBox1
    '
    Me.ComboBox1.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
    Me.ComboBox1.FormattingEnabled = True
    Me.ComboBox1.Location = New System.Drawing.Point(13, 14)
    Me.ComboBox1.Name = "ComboBox1"
    Me.ComboBox1.Size = New System.Drawing.Size(207, 21)
    Me.ComboBox1.TabIndex = 0
    '
    'DataGrid1
    '
    Me.DataGrid1.Anchor = CType((((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
                Or System.Windows.Forms.AnchorStyles.Left) _
                Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
    Me.DataGrid1.CaptionText = "Titles"
    Me.DataGrid1.DataMember = ""
    Me.DataGrid1.HeaderForeColor = System.Drawing.SystemColors.ControlText
    Me.DataGrid1.Location = New System.Drawing.Point(13, 49)
    Me.DataGrid1.Name = "DataGrid1"
    Me.DataGrid1.ReadOnly = True
    Me.DataGrid1.Size = New System.Drawing.Size(218, 132)
    Me.DataGrid1.TabIndex = 1
    '
    'Form1
    '
    Me.AutoScaleBaseSize = New System.Drawing.Size(5, 13)
    Me.ClientSize = New System.Drawing.Size(238, 187)
    Me.Controls.Add(Me.DataGrid1)
    Me.Controls.Add(Me.ComboBox1)
    Me.Name = "Form1"
    Me.Text = "ADO.NET sample"
    CType(Me.DataGrid1, System.ComponentModel.ISupportInitialize).EndInit()
    Me.ResumeLayout(False)

  End Sub

#End Region

  Dim myconn As MySqlConnection
  Dim titlecommand As MySqlCommand
  Dim publparam As MySqlParameter


  Private Sub Form1_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
    ' connect to database
    myconn = New MySqlConnection( _
      "Data Source=192.168.80.128;Initial Catalog=mylibrary;" + _
      "User ID=root;PWD=uranus")
    myconn.Open()

    'prepare command for title query
    titlecommand = New MySqlCommand( _
      "SELECT title, subtitle, langName FROM titles, languages " + _
      "WHERE publID = ?publ AND titles.langID = languages.langID " + _
      "ORDER BY title", _
      myconn)
    publparam = titlecommand.Parameters.Add("?publ", MySqlDbType.Int32)
    titlecommand.Prepare()

    ' fill publishers combo box
    Dim com As New MySqlCommand( _
      "SELECT publID, publName FROM publishers ORDER BY publName", _
      myconn)
    Dim da As New MySqlDataAdapter(com)
    Dim ds As New DataSet()
    da.Fill(ds, "publishers")
    ComboBox1.DisplayMember = "publName"
    ComboBox1.ValueMember = "publID"
    ComboBox1.DataSource = ds.Tables("publishers")
  End Sub

  Private Sub ComboBox1_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ComboBox1.SelectedIndexChanged
    publparam.Value = ComboBox1.SelectedValue
    Dim ds As New DataSet()
    Dim da As New MySqlDataAdapter(titlecommand)
    da.Fill(ds, "titles")
    DataGrid1.DataSource = ds.Tables("titles")
  End Sub
End Class
