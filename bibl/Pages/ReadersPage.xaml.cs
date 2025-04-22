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

namespace bibl.Pages
{
    /// <summary>
    /// Логика взаимодействия для ReadersPage.xaml
    /// </summary>
    public partial class ReadersPage : Page
    {
        public ReadersPage()
        {
            InitializeComponent();
            LoadReaders();
        }

        private void LoadReaders()
        {
            // Загрузка читателей из базы данных
            var readers = DBcon.library.Readers.ToList();
            ReadersGrid.ItemsSource = readers;
        }

        private void SearchTextBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            // Поиск читателей
            var searchText = SearchTextBox.Text.ToLower();
            ReadersGrid.ItemsSource = DBcon.library.Readers
                .Where(r => r.FullName.ToLower().Contains(searchText) ||
                             r.Phone.Contains(searchText))
                .ToList();
        }
    }
}

