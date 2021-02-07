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
    public partial class SifremiUnuttum : Form
    {
        public SifremiUnuttum()
        {
            InitializeComponent();
        }
        OdbcConnection baglanti;

        
        private void SifremiUnuttum_Load(object sender, EventArgs e)
        {
            Text = "Şifremi Unuttum";
            StartPosition = FormStartPosition.CenterScreen;
            FormBorderStyle = FormBorderStyle.FixedToolWindow;

            try
            {
                baglanti = new OdbcConnection("DSN=PostgreSQL35W");
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
                throw;
            }
        }
        private bool durum = false;
        private void button1_Click(object sender, EventArgs e)
        {
            baglanti.Open();
            string sql = "SELECT \"KullaniciAdi\", \"Sifre\" , \"GuvenlikCevap\" FROM \"Kullanici\"";
            OdbcCommand cmd = new OdbcCommand(sql,baglanti);
            cmd = new OdbcCommand(sql, baglanti);
            OdbcDataReader dr = cmd.ExecuteReader();

            while (dr.Read())
            {
                if (dr[0].ToString() == textBox1.Text)
                {
                    durum = true;
                    if (dr[2].ToString() != textBox2.Text)
                    {
                        MessageBox.Show("Cevabınız Yanlış", "Hata", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        baglanti.Close();
                        break;
                    }
                    else
                    {
                        MessageBox.Show("Şifreniz : " + dr[1].ToString());
                        baglanti.Close();
                        break;
                    }
                }
            }
            if (durum == false)
            {
                MessageBox.Show("Böyle bir kullanıcı yok", "Hata", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }

            baglanti.Close();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            Giris asd = new Giris();
            Hide();
            asd.Show();
        }
    }
}
