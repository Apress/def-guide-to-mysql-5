namespace connector_net_intro
{
	partial class Form1
	{
		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.IContainer components = null;

		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		protected override void Dispose(bool disposing)
		{
			if (disposing && (components != null))
			{
				components.Dispose();
			}
			base.Dispose(disposing);
		}

		#region Windows Form Designer generated code

		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
      this.button1 = new System.Windows.Forms.Button();
      this.button2 = new System.Windows.Forms.Button();
      this.button3 = new System.Windows.Forms.Button();
      this.textBox1 = new System.Windows.Forms.TextBox();
      this.SuspendLayout();
// 
// button1
// 
      this.button1.Location = new System.Drawing.Point(10, 18);
      this.button1.Name = "button1";
      this.button1.Size = new System.Drawing.Size(67, 20);
      this.button1.TabIndex = 0;
      this.button1.Text = "Connect";
      this.button1.Click += new System.EventHandler(this.button1_Click);
// 
// button2
// 
      this.button2.Enabled = false;
      this.button2.Location = new System.Drawing.Point(103, 18);
      this.button2.Name = "button2";
      this.button2.Size = new System.Drawing.Size(74, 19);
      this.button2.TabIndex = 1;
      this.button2.Text = "Query";
      this.button2.Click += new System.EventHandler(this.button2_Click);
// 
// button3
// 
      this.button3.Location = new System.Drawing.Point(208, 18);
      this.button3.Name = "button3";
      this.button3.Size = new System.Drawing.Size(79, 19);
      this.button3.TabIndex = 2;
      this.button3.Text = "End";
      this.button3.Click += new System.EventHandler(this.button3_Click);
// 
// textBox1
// 
      this.textBox1.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                  | System.Windows.Forms.AnchorStyles.Left)
                  | System.Windows.Forms.AnchorStyles.Right)));
      this.textBox1.Location = new System.Drawing.Point(14, 51);
      this.textBox1.Multiline = true;
      this.textBox1.Name = "textBox1";
      this.textBox1.ScrollBars = System.Windows.Forms.ScrollBars.Both;
      this.textBox1.Size = new System.Drawing.Size(272, 201);
      this.textBox1.TabIndex = 3;
// 
// Form1
// 
      this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
      this.ClientSize = new System.Drawing.Size(296, 266);
      this.Controls.Add(this.textBox1);
      this.Controls.Add(this.button3);
      this.Controls.Add(this.button2);
      this.Controls.Add(this.button1);
      this.Name = "Form1";
      this.Text = "Connector/Net intro";
      this.ResumeLayout(false);
      this.PerformLayout();

    }

		#endregion

		private System.Windows.Forms.Button button1;
		private System.Windows.Forms.Button button2;
    private System.Windows.Forms.Button button3;
    private System.Windows.Forms.TextBox textBox1;
  }
}

