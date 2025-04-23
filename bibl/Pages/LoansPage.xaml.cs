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
using System.Globalization;
namespace bibl.Pages
{
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
                // Загружаем данные с учетом связей
                var loans = DBcon.library.BookVidacha
                    .Include(l => l.Books)
                    .Include(l => l.Books.Departments)  // Подгружаем отдел книги
                    .Include(l => l.Abonement)
                    .Include(l => l.Abonement.Readers)
                    .ToList();

                LoansGrid.ItemsSource = loans;
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка загрузки: {ex.Message}");
            }
        }

        // Обработчик кнопки "Вернуть"
        private void ReturnButton_Click(object sender, RoutedEventArgs e)
        {
            if (((Button)sender).Tag is int loanId)
            {
                try
                {
                    var loan = DBcon.library.BookVidacha.Find(loanId);
                    if (loan != null)
                    {
                        // Если книга еще не возвращена
                        if (loan.ReturnDate == null)
                        {
                            loan.ReturnDate = DateTime.Today;  // Ставим текущую дату
                            DBcon.library.SaveChanges();
                            LoadLoans();  // Обновляем таблицу
                            MessageBox.Show("Книга возвращена!");
                        }
                        else
                        {
                            MessageBox.Show("Эта книга уже возвращена!");
                        }
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show($"Ошибка: {ex.Message}");
                }
            }
        }
    }
}