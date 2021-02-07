using System;
using System.Data.Odbc;
using System.Windows.Forms;

namespace VeriTabani
{
    public partial class UcusEkle : Form
    {
        public UcusEkle()
        {
            InitializeComponent();
        }
        OdbcConnection baglanti;
        OdbcCommand cmd;
        OdbcDataReader reader;
        private void UcusEkle_Load(object sender, EventArgs e)
        {
            Text = "Uçuş Ekle";
            /****   kayit tarihi atarken format değişikliği       *****/
            dateTimePicker1.Format = DateTimePickerFormat.Custom;
            dateTimePicker1.CustomFormat = "yyyy-MM-dd hh:mm:ss";


            baglanti = new OdbcConnection("DSN=PostgreSQL35W");

            try
            {
                baglanti.Open();

                string sql = "SELECT \"Isim\", \"Soyisim\" FROM \"Pilot\"";
                cmd = new OdbcCommand(sql, baglanti);
                reader = cmd.ExecuteReader();

                // pilot isimlerini comboboxa atıyor
                while (reader.Read())
                {
                    comboBox1.Items.Add(reader[0].ToString() + " " + reader[1].ToString());
                }
                /**************************************************************/
                sql = "SELECT \"UcakKodu\" FROM \"Ucak\"";
                cmd = new OdbcCommand(sql,baglanti);
                reader = cmd.ExecuteReader();

                // uçak isimleri yazdırılıyor
                while(reader.Read())
                {
                    comboBox5.Items.Add(reader[0].ToString());
                }
                /*******************************************************************/

                sql = "SELECT \"SirketIsmi\" FROM \"Sirket\"";
                cmd = new OdbcCommand(sql, baglanti);
                reader = cmd.ExecuteReader();

                // sirket isimleri yazdırılıyor
                while (reader.Read())
                {
                    comboBox6.Items.Add(reader[0].ToString());
                }

                /*******************************************************************/

                sql = "SELECT \"UgradigiUlkeler\" FROM \"Rota\"";
                cmd = new OdbcCommand(sql, baglanti);
                reader = cmd.ExecuteReader();

                // rota isimleri yazdırılıyor
                while (reader.Read())
                {
                    comboBox3.Items.Add(reader[0].ToString());
                }

                /*******************************************************************/

                sql = "SELECT \"Ismi\" FROM \"HavaAlani\"";
                cmd = new OdbcCommand(sql, baglanti);
                reader = cmd.ExecuteReader();

                // havaalanı isimleri yazdırılıyor
                while (reader.Read())
                {
                    comboBox2.Items.Add(reader[0].ToString());
                }

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
            int pilot = comboBox1.SelectedIndex + 1;
            int ucak = comboBox5.SelectedIndex + 1;
            int sirket = comboBox6.SelectedIndex + 1;
            int rota = comboBox3.SelectedIndex + 1;
            int havaalani = comboBox2.SelectedIndex + 1;
            string sure = textBox1.Text;
            string date = dateTimePicker1.Text;
            // uçuş ekleme işlemi yapılıyor
            try
            {

                baglanti.Open();
                string sql = "INSERT INTO \"public\".\"Ucus\" ( \"Pilot\", \"Rota\", \"Sirket\", \"Tarih\", \"Ucak\", \"UcusSuresi\", \"VarisHavaAlani\") VALUES (" + pilot + " ," + rota + " ," + sirket + " ,'" + date + "', " + ucak + " , '" + sure + "'," + havaalani + " )";
                cmd = new OdbcCommand(sql, baglanti);
                cmd.ExecuteNonQuery();
                baglanti.Close();
            }
            catch (Exception ex)
            {
                baglanti.Close();
                MessageBox.Show(ex.Message);
                throw;
            }

            UcusEkleSil ucus = new UcusEkleSil();
            ucus.Show();
            Hide();
        }
    }
}
