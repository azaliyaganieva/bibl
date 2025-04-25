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
            LoadActiveLoans();
        }

        private void LoadActiveLoans()
        {
            try
            {
                // Проверяем подключение
                if (!DBcon.library.Database.Exists())
                {
                    MessageBox.Show("Нет подключения к базе данных");
                    return;
                }

                // Создаем 5 тестовых выдач, если их меньше 3
                CreateTestLoansIfNeeded();

                // Получаем все активные выдачи
                var activeLoans = DBcon.library.Database.SqlQuery<LoanDisplayItem>(@"
                    SELECT 
                        v.ID as LoanId,
                        b.Title as BookTitle,
                        d.DepartmentName,
                        r.FullName as ReaderName,
                        v.LoanDate,
                        v.ReturnDate
                    FROM BookVidacha v
                    JOIN Books b ON v.BookID = b.ID
                    JOIN Departments d ON b.DepartmentID = d.ID
                    JOIN Abonement a ON v.SubscriptionID = a.ID
                    JOIN Readers r ON a.ReaderID = r.ID
                   
                    ORDER BY v.LoanDate DESC
                ").ToList();

                LoansGrid.ItemsSource = activeLoans;
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка загрузки: {ex.Message}");
            }
        }

        private void CreateTestLoansIfNeeded()
        {
            // Проверяем количество активных выдач
            var activeCount = DBcon.library.BookVidacha.Count(v => v.ReturnDate == null);

            if (activeCount < 3)
            {
                var books = DBcon.library.Books.Take(5).ToList();
                var readers = DBcon.library.Abonement.Take(5).ToList();
                var employees = DBcon.library.Employees.Take(2).ToList();

                if (books.Count >= 3 && readers.Count >= 3)
                {
                    for (int i = 0; i < 3; i++)
                    {
                        var newLoan = new BookVidacha
                        {
                            BookID = books[i].ID,
                            SubscriptionID = readers[i].ID,
                            LoanDate = DateTime.Today.AddDays(-i),
                            EmployeeID = employees[i % employees.Count].ID
                        };
                        DBcon.library.BookVidacha.Add(newLoan);
                    }
                    DBcon.library.SaveChanges();
                }
            }
        }

        private void ReturnButton_Click(object sender, RoutedEventArgs e)
        {
            if (((Button)sender).Tag is int loanId)
            {
                try
                {
                    var loan = DBcon.library.BookVidacha.Find(loanId);
                    if (loan != null && loan.ReturnDate == null)
                    {
                        loan.ReturnDate = DateTime.Today;
                        DBcon.library.SaveChanges();
                        LoadActiveLoans(); // Обновляем список

                        MessageBox.Show($"Книга '{loan.Books.Title}' возвращена!",
                                      "Успех",
                                      MessageBoxButton.OK,
                                      MessageBoxImage.Information);
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show($"Ошибка: {ex.Message}",
                                  "Ошибка",
                                  MessageBoxButton.OK,
                                  MessageBoxImage.Error);
                }
            }
        }

        // Класс для отображения данных
        public class LoanDisplayItem
        {
            public int LoanId { get; set; }
            public string BookTitle { get; set; }
            public string DepartmentName { get; set; }
            public string ReaderName { get; set; }
            public DateTime LoanDate { get; set; }
            public DateTime? ReturnDate { get; set; }
        }
    }
}
