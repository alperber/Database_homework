using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.Odbc;

namespace VeriTabani
{
    public partial class KullaniciPaneli : Form
    {
        public static string biletID;
        public KullaniciPaneli()
        {
            InitializeComponent();
        }
        OdbcConnection baglanti;
        private void KullaniciPaneli_Load(object sender, EventArgs e)
        {
            dataGridView1.DataSource = null;
            dataGridView1.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;
            Text = "Kullanıcı Paneli";
            StartPosition = FormStartPosition.CenterScreen;
            FormBorderStyle = FormBorderStyle.FixedToolWindow;
            baglanti = new OdbcConnection("DSN=PostgreSQL35W");
            try
            {
                baglanti.Open();
                string sql = "SELECT * FROM biletlistele(" + Giris.kID + ");";
                OdbcCommand komut = new OdbcCommand(sql, baglanti);
                DataTable table = new DataTable();
                table.Load(komut.ExecuteReader());
                dataGridView1.DataSource = table;

                baglanti.Close();
            }
            catch (Exception ex)
            {
                baglanti.Close();
                MessageBox.Show(ex.Message);
                throw;
            }
            
        }

        private void button1_Click(object sender, EventArgs e)
        {
            BiletAl bilet = new BiletAl();
            bilet.Show();
            Hide();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            Mesaj mesaj = new Mesaj();
            mesaj.Show();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            baglanti.Open();
            try
            {
                string sql = "DELETE FROM \"Bilet\" WHERE \"BiletID\" = " + textBox1.Text + ";";
                OdbcCommand cmd = new OdbcCommand(sql, baglanti);
                cmd.ExecuteNonQuery();
                MessageBox.Show("Bilet Başarıyla İptal Edildi", "Başarılı", MessageBoxButtons.OK,MessageBoxIcon.Information);

                // tekrar biletlerin listelenmesi için
                sql = "SELECT * FROM \"biletlistele\"(" + Giris.kID + ");";
                OdbcCommand komut = new OdbcCommand(sql, baglanti);
                DataTable table = new DataTable();
                table.Load(komut.ExecuteReader());
                dataGridView1.DataSource = table;

                baglanti.Close();
            }
            catch (Exception ex)
            {
                baglanti.Close();
                MessageBox.Show(ex.Message);
                throw;
            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            Giris giris = new Giris();
            Hide();
            giris.Show();
        }
    }
}
