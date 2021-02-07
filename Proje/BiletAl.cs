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
    public partial class BiletAl : Form
    {
        OdbcConnection baglanti;
        OdbcCommand komut;
        OdbcDataReader read;
        DataTable ucuslar;
        public BiletAl()
        {
            InitializeComponent();
        }

        private void Listele()
        {
            try
            {
                ucusListe.DataSource = null;
                baglanti.Open();
                string sql = "SELECT * FROM ucusListele();";
                komut = new OdbcCommand(sql, baglanti);
                read = komut.ExecuteReader();
                ucuslar = new DataTable();
                ucuslar.Load(read);
                ucusListe.DataSource = ucuslar;
                baglanti.Close();
            }
            catch (Exception ex)
            {
                baglanti.Close();
                MessageBox.Show(ex.Message);
                throw;
            }
        }

        private void BiletAl_Load(object sender, EventArgs e)
        {
            Text = "Bilet Paneli";
            StartPosition = FormStartPosition.CenterScreen;
            FormBorderStyle = FormBorderStyle.FixedToolWindow;
            ucusListe.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;

            try
            {
                baglanti = new OdbcConnection("DSN=PostgreSQL35W");
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
                throw;
            }

            Listele();

        }

        private void button1_Click(object sender, EventArgs e)
        {
            string sql = "INSERT INTO \"public\".\"Bilet\" ( \"KullaniciID\", \"UcusID\") VALUES ( '" + Giris.kID + "', '"+ textBox1.Text + "' );";
            OdbcConnection odbc = new OdbcConnection("DSN=PostgreSQL35W");
            try
            {
                odbc.Open();
                OdbcCommand cmd = new OdbcCommand(sql, odbc);
                cmd.ExecuteNonQuery();
                MessageBox.Show("Bilet Başarıyla Alındı", "", MessageBoxButtons.OK,MessageBoxIcon.Information);
                odbc.Close();
            }
            catch (Exception ex)
            {
                odbc.Close();
                MessageBox.Show(ex.Message,"Hata",MessageBoxButtons.OK,MessageBoxIcon.Error);
                throw;
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            KullaniciPaneli kullanici = new KullaniciPaneli();
            kullanici.Show();
            Hide();
        }
    }
}
