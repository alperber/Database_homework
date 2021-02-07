using System;
using System.Data;
using System.Data.Odbc;
using System.Windows.Forms;

namespace VeriTabani
{
    public partial class UcusEkleSil : Form
    {
        public UcusEkleSil()
        {
            InitializeComponent();
        }
        OdbcConnection baglanti;
        OdbcCommand komut;
        OdbcDataReader read;
        DataTable ucuslar;

        private void UcusEkleSil_Load(object sender, EventArgs e)
        {
            dataGridView1.DataSource = null;
            Text = "Uçuş Yönetim Paneli";
            StartPosition = FormStartPosition.CenterScreen;
            FormBorderStyle = FormBorderStyle.FixedToolWindow;
            dataGridView1.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;
            baglanti = new OdbcConnection("DSN=PostgreSQL35W");

            try
            {
                dataGridView1.DataSource = null;
                baglanti.Open();
                string sql = "SELECT * FROM ucusListele();";
                komut = new OdbcCommand(sql, baglanti);
                read = komut.ExecuteReader();
                ucuslar = new DataTable();
                ucuslar.Load(read);
                dataGridView1.DataSource = ucuslar;
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
            UcusEkle ekle = new UcusEkle();
            ekle.Show();
            Hide();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            Yonetici yonetici = new Yonetici();
            yonetici.Show();
            Hide();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            // silme işlemi
            baglanti.Open();

            try
            {
                string sql = "DELETE FROM \"Ucus\" WHERE \"UcusID\" = " + textBox1.Text + ";"; 
                komut = new OdbcCommand(sql, baglanti);
                komut.ExecuteNonQuery();
                baglanti.Close();
            }
            catch (Exception ex)
            {
                baglanti.Close();
                MessageBox.Show(ex.Message);
                throw;
            }

            // sildikten sonra tekrar listeleme
            try
            {
                dataGridView1.DataSource = null;
                baglanti.Open();
                string sql = "SELECT * FROM ucusListele();";
                komut = new OdbcCommand(sql, baglanti);
                read = komut.ExecuteReader();
                ucuslar = new DataTable();
                ucuslar.Load(read);
                dataGridView1.DataSource = ucuslar;
                baglanti.Close();
            }
            catch (Exception ex)
            {
                baglanti.Close();
                MessageBox.Show(ex.Message);
                throw;
            }
        }
    }
}
