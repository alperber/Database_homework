using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace VeriTabani
{
    public partial class Yonetici : Form
    {
        public Yonetici()
        {
            InitializeComponent();
        }

        private void Yonetici_Load(object sender, EventArgs e)
        {
            Text = "Yönetici Paneli";
            StartPosition = FormStartPosition.CenterScreen;
            FormBorderStyle = FormBorderStyle.FixedToolWindow;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Hide();
            Rapor rapor = new Rapor();
            rapor.Show();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            Hide();
            KullaniciSil kullaniciSil = new KullaniciSil();
            kullaniciSil.Show();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            Hide();
            UcusEkleSil ekleSil = new UcusEkleSil();
            ekleSil.Show();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            Giris giris = new Giris();
            Hide();
            giris.Show();
        }
    }
}
