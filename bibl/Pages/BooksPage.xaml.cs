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

        private void LoadBooks()
        {
            BooksGrid.ItemsSource = DBcon.library.Books
                .Include(b => b.Departments)
                .ToList();
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

            // Фильтр по поисковому запросу
            if (!string.IsNullOrEmpty(SearchTextBox.Text))
            {
                string searchText = SearchTextBox.Text.ToLower();
                query = query.Where(b =>
                    (b.Title != null && b.Title.ToLower().Contains(searchText)) ||
                    (b.Author != null && b.Author.ToLower().Contains(searchText)));
            }

            // Фильтр по отделу
            if (DepartmentFilter.SelectedItem is Data.Departments selectedDepartment)
            {
                query = query.Where(b => b.DepartmentID == selectedDepartment.ID);
            }

            BooksGrid.ItemsSource = query.ToList();
        }
    }
}
