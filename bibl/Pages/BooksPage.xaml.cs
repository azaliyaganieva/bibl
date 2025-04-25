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
using System.Data.Entity; // Добавьте эту директиву
using bibl.Data;


namespace bibl.Pages
{
    public partial class BooksPage : Page
    {
        public BooksPage()
        {
            InitializeComponent();
            LoadBooks();
            LoadDepartments();
        }

        public void LoadBooks()
        {
            try
            {
                // Используем явный SQL-запрос
                var query = @"SELECT b.ID, b.Title, b.Author, b.PublicationYear, 
                             d.DepartmentName, b.DepartmentID
                      FROM Books b
                      LEFT JOIN Departments d ON b.DepartmentID = d.ID
                      WHERE NOT EXISTS (
                          SELECT 1 FROM BookVidacha v 
                          WHERE v.BookID = b.ID AND v.ReturnDate IS NULL
                      )";

                var books = DBcon.library.Database.SqlQuery<BookDisplay>(query).ToList();
                BooksGrid.ItemsSource = books;
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка: {ex.Message}");
            }
        }

        // Класс для отображения
        public class BookDisplay
        {
            public int ID { get; set; }
            public string Title { get; set; }
            public string Author { get; set; }
            public int? PublicationYear { get; set; }
            public string DepartmentName { get; set; } // Будет отображаться в колонке
            public int? DepartmentID { get; set; }
        }
        private void LoadDepartments()
        {
            DepartmentFilter.ItemsSource = DBcon.library.Departments.ToList();
            DepartmentFilter.DisplayMemberPath = "DepartmentName";
            DepartmentFilter.SelectedValuePath = "ID";
        }

        // Обработчик изменения текста поиска
        private void SearchTextBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            ApplyFilters();
        }

        // Обработчик изменения выбора отдела
        private void DepartmentFilter_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            ApplyFilters();
        }

        // Обработчик кнопки "Выдать"
        private void LoanButton_Click(object sender, RoutedEventArgs e)
        {
            if (((Button)sender).Tag is int bookId)
            {
                var book = DBcon.library.Books.Find(bookId);
                if (book != null)
                {
                    var loanWindow = new Windows.AddLoanWindow(bookId);
                    if (loanWindow.ShowDialog() == true)
                    {
                        LoadBooks(); // Обновляем список после выдачи
                    }
                }
            }
        }

        // Применение фильтров
        private void ApplyFilters()
        {
            var query = DBcon.library.Books
                .Include(b => b.Departments)
                .AsQueryable();

            // Фильтр по поиску
            if (!string.IsNullOrEmpty(SearchTextBox.Text))
            {
                string searchText = SearchTextBox.Text.ToLower();
                query = query.Where(b =>
                    b.Title.ToLower().Contains(searchText) ||
                    (b.Author != null && b.Author.ToLower().Contains(searchText)));
            }

            // Фильтр по отделу
            if (DepartmentFilter.SelectedItem != null)
            {
                int selectedId = (int)DepartmentFilter.SelectedValue;
                query = query.Where(b => b.DepartmentID == selectedId);
            }

            BooksGrid.ItemsSource = query.ToList();
        }
        
    }
}
