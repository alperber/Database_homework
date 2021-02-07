using System;
using System.Data.Odbc;
using System.Windows.Forms;

namespace VeriTabani
{
    public partial class Rapor : Form
    {
        public Rapor()
        {
            InitializeComponent();
        }

        private void Rapor_Load(object sender, EventArgs e)
        {
            Text = "Rapor Paneli";
            StartPosition = FormStartPosition.CenterScreen;
            FormBorderStyle = FormBorderStyle.FixedToolWindow;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            OdbcConnection baglanti = new OdbcConnection("DSN=PostgreSQL35W");
            string sql = "INSERT INTO \"public\".\"Rapor\" ( \"Konu\", \"Metin\", \"YoneticiID\") VALUES ( '" + textBox2.Text +"', '" + textBox1.Text +"', '" + Giris.kID + "' );";
            try
            {
                baglanti.Open();
                OdbcCommand cmd = new OdbcCommand(sql,baglanti);
                cmd.ExecuteNonQuery();
                baglanti.Close();
                MessageBox.Show("Rapor Başarıyla Gönderildi","Başarılı",MessageBoxButtons.OK,MessageBoxIcon.Information);
            }
            catch (Exception ex)
            {
                baglanti.Close();
                MessageBox.Show(ex.Message,"Hata",MessageBoxButtons.OK,MessageBoxIcon.Error);
                throw;
            }
            Yonetici yonetici = new Yonetici();
            yonetici.Show();
            Hide();
        }
    }
}
