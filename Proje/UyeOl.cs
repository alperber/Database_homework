using System;
using System.Windows.Forms;
using System.Data.Odbc;

namespace VeriTabani
{
    public partial class UyeOl : Form
    {
        public UyeOl()
        {
            InitializeComponent();
        }

        private void UyeOl_Load(object sender, EventArgs e)
        {
            textBox2.PasswordChar = '*';
            Text = "Kayıt Paneli";
            StartPosition = FormStartPosition.CenterScreen;
            FormBorderStyle = FormBorderStyle.FixedToolWindow;

        }
        OdbcConnection odbc;
        private void button1_Click(object sender, EventArgs e)
        {
            if(textBox1.Text == "")
            {
                MessageBox.Show("Lütfen isim giriniz" , "Hata" ,MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            else if (textBox5.Text == "")
            {
                MessageBox.Show("Lütfen soyisim giriniz", "Hata", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            else if (textBox4.Text == "")
            {
                MessageBox.Show("Lütfen e-mail giriniz", "Hata", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            else if (textBox3.Text == "")
            {
                MessageBox.Show("Lütfen kullanıcı adı giriniz", "Hata", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            else if (textBox2.Text == "")
            {
                MessageBox.Show("Lütfen şire giriniz", "Hata", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            else if (textBox6.Text == "")
            {
                MessageBox.Show("Lütfen güvenlik sorusunun cevabını giriniz", "Hata", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            else if (textBox8.Text == "")
            {
                MessageBox.Show("Lütfen telefon numaranızı giriniz", "Hata", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            else if (textBox7.Text == "")
            {
                MessageBox.Show("Lütfen mesleğinizi giriniz", "Hata", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            else
            { // ekleme yapılıyor
                try
                {
                    odbc = new OdbcConnection("DSN=PostgreSQL35W");
                    odbc.Open();
                    string sql = "INSERT INTO \"Kullanici\" (\"Adi\", \"Soyadi\", \"KullaniciAdi\", \"GuvenlikCevap\", \"Sifre\", \"E-mail\", \"Telefon\", \"Meslek\") VALUES ('" + textBox1.Text + "', '" + textBox5.Text + "', '" + textBox3.Text + "', '" + textBox6.Text + "', '" + textBox2.Text + "', '" + textBox4.Text + "', '" + textBox8.Text + "', '" + textBox7.Text + "')"; 
                    OdbcCommand cmd = new OdbcCommand(sql,odbc);
                    cmd.ExecuteNonQuery();

                    MessageBox.Show("Başarıyla Kaydoldunuz");
                    Hide();
                    Giris giris = new Giris();
                    giris.Show();

                }
                catch (Exception ex)
                {
                    odbc.Close();
                    MessageBox.Show(ex.Message);
                    throw;
                }
                
            }
        }
    }
}
