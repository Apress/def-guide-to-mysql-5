  using System;
  using System.Drawing;
  using System.Collections;
  using System.ComponentModel;
  using System.Windows.Forms;
  using System.Data;
  using MySql.Data.MySqlClient;

namespace datacontrols
  {
	  /// <summary>
	  /// Summary description for Form1.
	  /// </summary>
	  public class Form1 : System.Windows.Forms.Form
	  {
		  private System.Windows.Forms.ComboBox comboBox1;
		  private System.Windows.Forms.DataGrid dataGrid1;
		  /// <summary>
		  /// Required designer variable.
		  /// </summary>
		  private System.ComponentModel.Container components = null;

		  public Form1()
		  {
			  //
			  // Required for Windows Form Designer support
			  //
			  InitializeComponent();

			  //
			  // TODO: Add any constructor code after InitializeComponent call
			  //
		  }

		  /// <summary>
		  /// Clean up any resources being used.
		  /// </summary>
		  protected override void Dispose( bool disposing )
		  {
			  if( disposing )
			  {
				  if (components != null) 
				  {
					  components.Dispose();
				  }
			  }
			  base.Dispose( disposing );
		  }

		  #region Windows Form Designer generated code
		  /// <summary>
		  /// Required method for Designer support - do not modify
		  /// the contents of this method with the code editor.
		  /// </summary>
		  private void InitializeComponent()
		  {
        this.comboBox1 = new System.Windows.Forms.ComboBox();
        this.dataGrid1 = new System.Windows.Forms.DataGrid();
        ((System.ComponentModel.ISupportInitialize)(this.dataGrid1)).BeginInit();
        this.SuspendLayout();
        // 
        // comboBox1
        // 
        this.comboBox1.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
        this.comboBox1.Location = new System.Drawing.Point(8, 8);
        this.comboBox1.Name = "comboBox1";
        this.comboBox1.Size = new System.Drawing.Size(216, 24);
        this.comboBox1.TabIndex = 0;
        this.comboBox1.SelectedIndexChanged += new System.EventHandler(this.comboBox1_SelectedIndexChanged);
        // 
        // dataGrid1
        // 
        this.dataGrid1.Anchor = (((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
          | System.Windows.Forms.AnchorStyles.Left) 
          | System.Windows.Forms.AnchorStyles.Right);
        this.dataGrid1.CaptionText = "Titles";
        this.dataGrid1.DataMember = "";
        this.dataGrid1.HeaderForeColor = System.Drawing.SystemColors.ControlText;
        this.dataGrid1.Location = new System.Drawing.Point(8, 48);
        this.dataGrid1.Name = "dataGrid1";
        this.dataGrid1.ReadOnly = true;
        this.dataGrid1.Size = new System.Drawing.Size(280, 216);
        this.dataGrid1.TabIndex = 1;
        // 
        // Form1
        // 
        this.AutoScaleBaseSize = new System.Drawing.Size(6, 15);
        this.ClientSize = new System.Drawing.Size(296, 271);
        this.Controls.AddRange(new System.Windows.Forms.Control[] {
                                                                    this.dataGrid1,
                                                                    this.comboBox1});
        this.Name = "Form1";
        this.Text = "ADO.NET sample";
        this.Load += new System.EventHandler(this.Form1_Load);
        ((System.ComponentModel.ISupportInitialize)(this.dataGrid1)).EndInit();
        this.ResumeLayout(false);

      }
		  #endregion

		  /// <summary>
		  /// The main entry point for the application.
		  /// </summary>
		  [STAThread]
		  static void Main() 
		  {
			  Application.Run(new Form1());
		  }

		  MySqlConnection mysqlconn;
      MySqlCommand titlecommand;
      MySqlParameter publparam;

      // initialization
		  private void Form1_Load(object sender, System.EventArgs e){
        // connect to MySQL
        mysqlconn = new MySqlConnection(
          "Data Source=192.168.80.128;Initial Catalog=mylibrary;" +
          "User ID=root;PWD=uranus");
        mysqlconn.Open();
  		
        // prepare command for title query
        titlecommand = new MySqlCommand( 
          "SELECT title, subtitle, langName FROM titles, languages " + 
          "WHERE publID = ?publ AND titles.langID = languages.langID " + 
          "ORDER BY title", 
          mysqlconn);
        publparam = titlecommand.Parameters.Add("?publ", MySqlDbType.Int32);
        titlecommand.Prepare();

        // fill publishers combo box
        MySqlCommand com = new MySqlCommand( 
          "SELECT publID, publName FROM publishers ORDER BY publName", 
          mysqlconn);
        MySqlDataAdapter da = new MySqlDataAdapter(com);
        DataSet ds = new DataSet();
        da.Fill(ds, "publishers");
        comboBox1.DisplayMember = "publName";
        comboBox1.ValueMember = "publID";
        comboBox1.DataSource = ds.Tables["publishers"];
		  }

      private void comboBox1_SelectedIndexChanged(object sender, System.EventArgs e) {
        publparam.Value = comboBox1.SelectedValue;
        DataSet ds = new DataSet();
        MySqlDataAdapter da = new MySqlDataAdapter(titlecommand);
        da.Fill(ds, "titles");
        dataGrid1.DataSource = ds.Tables["titles"];
      }
	  }
  }
