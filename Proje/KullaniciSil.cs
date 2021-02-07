using System;
using System.Data;
using System.Data.Odbc;

using System.Windows.Forms;

namespace VeriTabani
{
    public partial class KullaniciSil : Form
    {
        public KullaniciSil()
        {
            InitializeComponent();
        }
        OdbcConnection odbc;
        private void KullaniciSil_Load(object sender, EventArgs e)
        {
            dataGridView1.DataSource = null;
            Text = "Kullanıcı Yönetim Paneli";
            StartPosition = FormStartPosition.CenterScreen;
            FormBorderStyle = FormBorderStyle.FixedToolWindow;
            dataGridView1.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;

            odbc = new OdbcConnection("DSN=PostgreSQL35W");
            string sql = "SELECT * FROM kullaniciListele();";
            DataTable dt = new DataTable();
            try
            {
                odbc.Open();
                OdbcCommand cmd = new OdbcCommand(sql,odbc);
                dt.Load(cmd.ExecuteReader());
                dataGridView1.DataSource = dt;
                odbc.Close();
            }
            catch (Exception ex)
            {
                odbc.Close();
                MessageBox.Show(ex.Message);
                throw;
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string sql = "DELETE FROM \"Kullanici\" WHERE \"KullaniciID\" = " + textBox1.Text + ";";
            odbc = new OdbcConnection("DSN=PostgreSQL35W");
            try
            {
                odbc.Open();
                OdbcCommand cmd = new OdbcCommand(sql,odbc);
                cmd.ExecuteNonQuery();

                odbc.Close();
            }
            catch (Exception ex)
            {
                odbc.Close();
                MessageBox.Show(ex.Message);
                throw;
            }

            // tekrar listelemek için
            dataGridView1.DataSource = null;
            string sql2 = "SELECT * FROM kullaniciListele();";
            DataTable dt = new DataTable();
            try
            {
                odbc.Open();
                OdbcCommand cmd = new OdbcCommand(sql2, odbc);
                dt.Load(cmd.ExecuteReader());
                dataGridView1.DataSource = dt;
                odbc.Close();
            }
            catch (Exception ex)
            {
                odbc.Close();
                MessageBox.Show(ex.Message);
                throw;
            }
            textBox1.Text = "";
        }

        private void button2_Click(object sender, EventArgs e)
        {
            Yonetici yonetici = new Yonetici();
            Hide();
            yonetici.Show();
        }
    }
}
