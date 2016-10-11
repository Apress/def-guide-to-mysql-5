Partial Public Class Form1
    Inherits System.Windows.Forms.Form

    <System.Diagnostics.DebuggerNonUserCode()> _
    Public Sub New()
        MyBase.New()

        'This call is required by the Windows Form Designer.
        InitializeComponent()

    End Sub

    'Form overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overloads Overrides Sub Dispose(ByVal disposing As Boolean)
        If disposing AndAlso components IsNot Nothing Then
            components.Dispose()
        End If
        MyBase.Dispose(disposing)
    End Sub

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
    Me.btnConnect = New System.Windows.Forms.Button
    Me.btnSave = New System.Windows.Forms.Button
    Me.btnEnd = New System.Windows.Forms.Button
    Me.btnLoad = New System.Windows.Forms.Button
    Me.PictureBox1 = New System.Windows.Forms.PictureBox
    CType(Me.PictureBox1, System.ComponentModel.ISupportInitialize).BeginInit()
    Me.SuspendLayout()
    '
    'btnConnect
    '
    Me.btnConnect.Location = New System.Drawing.Point(7, 13)
    Me.btnConnect.Name = "btnConnect"
    Me.btnConnect.Size = New System.Drawing.Size(168, 34)
    Me.btnConnect.TabIndex = 0
    Me.btnConnect.Text = "Connect"
    '
    'btnSave
    '
    Me.btnSave.Enabled = False
    Me.btnSave.Location = New System.Drawing.Point(7, 54)
    Me.btnSave.Name = "btnSave"
    Me.btnSave.Size = New System.Drawing.Size(168, 34)
    Me.btnSave.TabIndex = 1
    Me.btnSave.Text = "Save test.jpg in database"
    '
    'btnEnd
    '
    Me.btnEnd.Location = New System.Drawing.Point(7, 136)
    Me.btnEnd.Name = "btnEnd"
    Me.btnEnd.Size = New System.Drawing.Size(168, 34)
    Me.btnEnd.TabIndex = 3
    Me.btnEnd.Text = "End"
    '
    'btnLoad
    '
    Me.btnLoad.Enabled = False
    Me.btnLoad.Location = New System.Drawing.Point(7, 95)
    Me.btnLoad.Name = "btnLoad"
    Me.btnLoad.Size = New System.Drawing.Size(168, 34)
    Me.btnLoad.TabIndex = 2
    Me.btnLoad.Text = "Load picture from database, show it and save it in test1.jpg"
    '
    'PictureBox1
    '
    Me.PictureBox1.Anchor = CType((((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
                Or System.Windows.Forms.AnchorStyles.Left) _
                Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
    Me.PictureBox1.Location = New System.Drawing.Point(191, 17)
    Me.PictureBox1.Name = "PictureBox1"
    Me.PictureBox1.Size = New System.Drawing.Size(284, 229)
    Me.PictureBox1.TabIndex = 4
    Me.PictureBox1.TabStop = False
    '
    'Form1
    '
    Me.AutoScaleBaseSize = New System.Drawing.Size(5, 13)
    Me.ClientSize = New System.Drawing.Size(487, 259)
    Me.Controls.Add(Me.PictureBox1)
    Me.Controls.Add(Me.btnEnd)
    Me.Controls.Add(Me.btnLoad)
    Me.Controls.Add(Me.btnSave)
    Me.Controls.Add(Me.btnConnect)
    Me.Name = "Form1"
    Me.Text = "BLOB test"
    CType(Me.PictureBox1, System.ComponentModel.ISupportInitialize).EndInit()
    Me.ResumeLayout(False)

  End Sub
  Friend WithEvents btnConnect As System.Windows.Forms.Button
  Friend WithEvents btnSave As System.Windows.Forms.Button
  Friend WithEvents btnEnd As System.Windows.Forms.Button
  Friend WithEvents btnLoad As System.Windows.Forms.Button
  Friend WithEvents PictureBox1 As System.Windows.Forms.PictureBox

End Class
