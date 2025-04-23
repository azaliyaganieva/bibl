using bibl.Connect;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using bibl.Data;
using System.Data.Entity;
namespace bibl.Pages
{
    /// <summary>
    /// Логика взаимодействия для LoansPage.xaml
    /// </summary>
    public partial class LoansPage : Page
    {
        public LoansPage()
        {
            InitializeComponent();
            LoadLoans();
        }
        private void LoadLoans()
        {
            try
            {
                var loans = DBcon.library.BookVidacha
                    .Include(l => l.Books)
                    .Include(l => l.Abonement)
                    .Include(l => l.Abonement.Readers)
                    .Include(l => l.Employees)
                    .ToList();

                LoansGrid.ItemsSource = loans;
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка загрузки выдач: {ex.Message}");
            }
        }
    }
}
