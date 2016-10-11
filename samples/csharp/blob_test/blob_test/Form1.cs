#region Using directives

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Windows.Forms;
using System.IO;
using MySql.Data.MySqlClient;

#endregion

namespace blob_test {
  partial class Form1 : Form {
    public Form1() {
      InitializeComponent();
    }

    MySqlConnection myconn;
    MySqlCommand com;
    int id;

    // connect to MySQL server, create testpic table
    private void btnConnect_Click(object sender, EventArgs e) {
      try {
        myconn = new MySqlConnection(
          "Data Source=192.168.80.128;Initial Catalog=mylibrary;" +
          "User ID=root;PWD=uranus");
        myconn.Open();
        com = new MySqlCommand(
          "CREATE TABLE IF NOT EXISTS testpic " + 
          "  (id INT NOT NULL AUTO_INCREMENT, pic MEDIUMBLOB, PRIMARY KEY (id))", 
          myconn);
        com.ExecuteNonQuery();
        btnSave.Enabled = true;
      }
      catch (Exception ex) {
        Console.WriteLine(ex.Message);
        this.Close();
      }
    }

    // load test1.jpg, save it in BLOB
    private void btnSave_Click(object sender, EventArgs e) {
      byte[] bindata;
      FileStream fs;
      MySqlParameter picpara;

      // prepare INSERT command
      com = new MySqlCommand( 
        "INSERT INTO testpic (pic) VALUES(?pic)", myconn);
      picpara = com.Parameters.Add("?pic", MySqlDbType.MediumBlob);
      com.Prepare();

      // read JPEG file into Byte array
      fs = new FileStream("test.jpg", FileMode.Open, FileAccess.Read);
      bindata = new byte[fs.Length];
      fs.Read(bindata, 0, (int)fs.Length);
      fs.Close();

      // call INSERT command, use Byte array as parameter
      picpara.Value = bindata;
      com.ExecuteNonQuery();

      // retrieve id of new record
      com.CommandText = "SELECT LAST_INSERT_ID()";
      id = (int)(long)com.ExecuteScalar();

      // enable load button
      btnLoad.Enabled = true;
    }

    // load data from BLOB, save in test1.jpg, show in PictureBox1
    private void btnLoad_Click(object sender, EventArgs e) {
      byte[] bindata;
      FileStream fs;
      MemoryStream ms;

      com = new MySqlCommand("SELECT pic FROM testpic WHERE id=" + id.ToString(), myconn);
      bindata = (byte[]) com.ExecuteScalar();

      // show JPEG file
      ms = new MemoryStream();
      ms.Write(bindata, 0, bindata.Length);
      PictureBox1.Image = new Bitmap(ms);

      // save new JPEG file
      fs = new FileStream("test1.jpg", FileMode.Create, FileAccess.Write);
      ms.WriteTo(fs);
      fs.Close();
    }
    
    private void btnEnd_Click(object sender, EventArgs e) {
      com = new MySqlCommand( 
        "DROP TABLE IF EXISTS testpic ", myconn);
      com.ExecuteNonQuery();
      this.Close();
    }

  }
}