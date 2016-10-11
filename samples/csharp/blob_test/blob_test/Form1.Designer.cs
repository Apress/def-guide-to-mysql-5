namespace blob_test {
  partial class Form1 {
    /// <summary>
    /// Required designer variable.
    /// </summary>
    private System.ComponentModel.IContainer components = null;

    /// <summary>
    /// Clean up any resources being used.
    /// </summary>
    protected override void Dispose(bool disposing) {
      if (disposing && (components != null)) {
        components.Dispose();
      }
      base.Dispose(disposing);
    }

    #region Windows Form Designer generated code

    /// <summary>
    /// Required method for Designer support - do not modify
    /// the contents of this method with the code editor.
    /// </summary>
    private void InitializeComponent() {
      this.PictureBox1 = new System.Windows.Forms.PictureBox();
      this.btnEnd = new System.Windows.Forms.Button();
      this.btnLoad = new System.Windows.Forms.Button();
      this.btnSave = new System.Windows.Forms.Button();
      this.btnConnect = new System.Windows.Forms.Button();
      ((System.ComponentModel.ISupportInitialize)(this.PictureBox1)).BeginInit();
      this.SuspendLayout();
// 
// PictureBox1
// 
      this.PictureBox1.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                  | System.Windows.Forms.AnchorStyles.Left)
                  | System.Windows.Forms.AnchorStyles.Right)));
      this.PictureBox1.Location = new System.Drawing.Point(197, 17);
      this.PictureBox1.Name = "PictureBox1";
      this.PictureBox1.Size = new System.Drawing.Size(311, 259);
      this.PictureBox1.TabIndex = 9;
      this.PictureBox1.TabStop = false;
// 
// btnEnd
// 
      this.btnEnd.Location = new System.Drawing.Point(13, 136);
      this.btnEnd.Name = "btnEnd";
      this.btnEnd.Size = new System.Drawing.Size(168, 34);
      this.btnEnd.TabIndex = 8;
      this.btnEnd.Text = "End";
      this.btnEnd.Click += new System.EventHandler(this.btnEnd_Click);
// 
// btnLoad
// 
      this.btnLoad.Enabled = false;
      this.btnLoad.Location = new System.Drawing.Point(13, 95);
      this.btnLoad.Name = "btnLoad";
      this.btnLoad.Size = new System.Drawing.Size(168, 34);
      this.btnLoad.TabIndex = 7;
      this.btnLoad.Text = "Load picture from database, show it and save it in test1.jpg";
      this.btnLoad.Click += new System.EventHandler(this.btnLoad_Click);
// 
// btnSave
// 
      this.btnSave.Enabled = false;
      this.btnSave.Location = new System.Drawing.Point(13, 54);
      this.btnSave.Name = "btnSave";
      this.btnSave.Size = new System.Drawing.Size(168, 34);
      this.btnSave.TabIndex = 6;
      this.btnSave.Text = "Save test.jpg in database";
      this.btnSave.Click += new System.EventHandler(this.btnSave_Click);
// 
// btnConnect
// 
      this.btnConnect.Location = new System.Drawing.Point(13, 13);
      this.btnConnect.Name = "btnConnect";
      this.btnConnect.Size = new System.Drawing.Size(168, 34);
      this.btnConnect.TabIndex = 5;
      this.btnConnect.Text = "Connect";
      this.btnConnect.Click += new System.EventHandler(this.btnConnect_Click);
// 
// Form1
// 
      this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
      this.ClientSize = new System.Drawing.Size(520, 288);
      this.Controls.Add(this.PictureBox1);
      this.Controls.Add(this.btnEnd);
      this.Controls.Add(this.btnLoad);
      this.Controls.Add(this.btnSave);
      this.Controls.Add(this.btnConnect);
      this.Name = "Form1";
      this.Text = "BLOB test";
      ((System.ComponentModel.ISupportInitialize)(this.PictureBox1)).EndInit();
      this.ResumeLayout(false);

    }

    #endregion

    internal System.Windows.Forms.PictureBox PictureBox1;
    internal System.Windows.Forms.Button btnEnd;
    internal System.Windows.Forms.Button btnLoad;
    internal System.Windows.Forms.Button btnSave;
    internal System.Windows.Forms.Button btnConnect;

  }
}

