using bibl.Windows;
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

namespace bibl.Pages
{
    /// <summary>
    /// Логика взаимодействия для MainPage.xaml
    /// </summary>
    public partial class MainPage : Page
    {
        public MainPage()
        {
            InitializeComponent();
            LoadBooksPage();
        }
        private void LoadBooksPage()
        {
            MainFrame.Navigate(new BooksPage());
        }

        private void BooksMenuItem_Click(object sender, RoutedEventArgs e)
        {
            LoadBooksPage();
        }

        private void AddBookMenuItem_Click(object sender, RoutedEventArgs e)
        {
            var addBookWindow = new Windows.AddBookWindow();
            if (addBookWindow.ShowDialog() == true)
            {
                LoadBooksPage(); // Обновляем список после добавления
            }
        }

        private void ReadersMenuItem_Click(object sender, RoutedEventArgs e)
        {
            MainFrame.Navigate(new ReadersPage());
        }

        private void AddReaderMenuItem_Click(object sender, RoutedEventArgs e)
        {
            var addReaderWindow = new Windows.AddReaderWindow();
            addReaderWindow.ShowDialog();
        }

        private void LoansMenuItem_Click(object sender, RoutedEventArgs e)
        {
            MainFrame.Navigate(new LoansPage());
        }

        private void AddLoanMenuItem_Click(object sender, RoutedEventArgs e)
        {
            var addLoanWindow = new AddLoanWindow();
            if (addLoanWindow.ShowDialog() == true)
            {
                // После закрытия окна обновляем данные
                var mainWindow = Application.Current.MainWindow as MainWindow;
              
            }
        }
    }
}

