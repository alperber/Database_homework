using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data.Odbc;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace VeriTabani
{
    public partial class Mesaj : Form
    {
        public Mesaj()
        {
            InitializeComponent();
        }

        private void Mesaj_Load(object sender, EventArgs e)
        {
            Text = "Mesaj Paneli";
            StartPosition = FormStartPosition.CenterScreen;
            FormBorderStyle = FormBorderStyle.FixedToolWindow;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string sql = "INSERT INTO \"public\".\"GeriBildirim\" ( \"KullaniciID\", \"Metin\")  VALUES ('" + Giris.kID +"', '"+ textBox1.Text +"');";
            OdbcConnection connection = new OdbcConnection("DSN=PostgreSQL35W");
            try
            {
                connection.Open();
                OdbcCommand cmd = new OdbcCommand(sql,connection);
                cmd.ExecuteNonQuery();
                connection.Close();
                MessageBox.Show("Geribildiriminiz Başarıyla İletildi");
                KullaniciPaneli kullanici = new KullaniciPaneli();
                Hide();
                kullanici.Show();
            }
            catch (Exception ex)
            {
                connection.Close();
                MessageBox.Show(ex.Message);
                throw;
            }
        }
    }
}
