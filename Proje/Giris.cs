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
    public partial class Giris : Form
    {
        public static string kAdi; // kullanıcı adı ve kullanıcıID diğer formlara aktarabilmek için static
        public static string kID;

        private OdbcCommand cmd;
        private OdbcConnection baglanti;
        public Giris()
        {
            InitializeComponent();
        }

        private void Giris_Load(object sender, EventArgs e)
        {
            textBox2.PasswordChar = '*';
            textBox3.PasswordChar = '*';
            Text = "Giriş Paneli";
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

        private void Label1_Click(object sender, EventArgs e)
        {

        }
        bool durum = false;
        private void button4_Click(object sender, EventArgs e)
        {// kullanici girisi
            baglanti.Open();
            string sql = "SELECT \"KullaniciAdi\", \"Sifre\" , \"KullaniciTuru\" , \"KullaniciID\" FROM \"Kullanici\"";
            cmd = new OdbcCommand(sql,baglanti);
            OdbcDataReader dr = cmd.ExecuteReader();
            
            while(dr.Read())
            {
                if(dr[0].ToString() == textBox4.Text && dr[1].ToString() == textBox3.Text && dr[2].ToString() == "K")
                {
                    kID = dr[3].ToString();
                    kAdi = textBox4.Text;
                    KullaniciPaneli panel = new KullaniciPaneli();
                    panel.Show();
                    Hide();
                    durum = true;
                    break;
                }
            }

            if(durum == false)
            {
                MessageBox.Show("Yanlış Kullanıcı Adı/Şifre", "Hata", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }

            baglanti.Close();
        }
        private void button3_Click(object sender, EventArgs e)
        {// yonetici girisi
            baglanti.Open();
            string sql = "SELECT \"KullaniciAdi\", \"Sifre\" , \"KullaniciTuru\" , \"KullaniciID\" FROM \"Kullanici\"";
            cmd = new OdbcCommand(sql, baglanti);
            OdbcDataReader dr = cmd.ExecuteReader();

            while (dr.Read())
            {
                if (dr[0].ToString() == textBox1.Text && dr[1].ToString() == textBox2.Text && dr[2].ToString() == "Y")
                {
                    kID = dr[3].ToString();
                    Yonetici yon = new Yonetici();
                    yon.Show();
                    Hide();
                    durum = true;
                    break;
                }
            }
            if(durum == false)
            {
                MessageBox.Show("Hatalı Kullanıcı Adı/Şifre", "Hata", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            
            baglanti.Close();
        }

        private void button5_Click(object sender, EventArgs e)
        {
            UyeOl uyeOl = new UyeOl();
            Hide();
            uyeOl.Show();
            
        }

        private void button6_Click(object sender, EventArgs e)
        {
            SifremiUnuttum sif = new SifremiUnuttum();
            Hide();
            sif.Show();
        }
    }
}
