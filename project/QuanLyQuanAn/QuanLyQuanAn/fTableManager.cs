using QuanLyQuanAn.DAO;
using QuanLyQuanAn.DTO;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace QuanLyQuanAn
{
    public partial class fTableManager : Form
    {
        public fTableManager()
        {
            InitializeComponent();
            LoadTable();
        }
        #region methods
        void LoadTable()
        {
           List<Table> tableList = TableDAO.Instance.LoadTableList();
            foreach (Table item in tableList)
            {
                Button btn = new Button() { Width = TableDAO.TableWidth, Height = TableDAO.TableHeigh};
                btn.Text = item.Name + Environment.NewLine + item.Status;
                if (item.Status == "Trống")
                {
                    btn.BackColor = Color.AliceBlue;
                }
                else
                    btn.BackColor = Color.Aqua;
                flpTable.Controls.Add(btn);
                
            }

        }
        #endregion

        #region Events
        private void đăngXuấtToolStripMenuItem_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void thôngTinCáNhânToolStripMenuItem_Click(object sender, EventArgs e)
        {
            fAccountProfile f = new fAccountProfile();
            //this.Hide();
            f.ShowDialog();
            //this.Show();
        }

        private void aToolStripMenuItem_Click(object sender, EventArgs e)
        {
            fAdmin f = new fAdmin();
            f.ShowDialog();
        }

#endregion
    }
}
