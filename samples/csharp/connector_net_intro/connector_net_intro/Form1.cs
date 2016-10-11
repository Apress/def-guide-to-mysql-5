#region Using directives

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Windows.Forms;
using MySql.Data.MySqlClient;

#endregion

namespace connector_net_intro {
  partial class Form1 : Form {
    MySqlConnection myconn;
    public Form1() {
      InitializeComponent();
    }

    private void button1_Click(object sender, EventArgs e) {
      try {
        myconn = new MySqlConnection(
          "Data Source=192.168.80.128;Initial Catalog=mylibrary;" + 
          "User ID=root;PWD=uranus");
        myconn.Open();
      }
      catch (MySqlException myerror) {
        MessageBox.Show("MySQL connection error: " + myerror.Message);
        this.Close();
      }
      button2.Enabled = true;
    }

    private void button2_Click(object sender, EventArgs e) {
      MySqlCommand com;
      MySqlDataReader dr;
      com = new MySqlCommand( 
        "SELECT publID, publName FROM publishers ORDER BY publName", 
        myconn);
      dr = com.ExecuteReader();
      while (dr.Read())
        textBox1.AppendText("id = " + dr["publID"] +
          ",  name = " + dr["publName"] + Environment.NewLine);
      dr.Close();
    }

    private void button3_Click(object sender, EventArgs e) {
      this.Close();
    }
  }
}