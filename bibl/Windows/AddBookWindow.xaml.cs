using bibl.Connect;
using bibl.Data;
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
using System.Windows.Shapes;

namespace bibl.Windows
{
    /// <summary>
    /// Логика взаимодействия для AddBookWindow.xaml
    /// </summary>
   
        public partial class AddBookWindow : Window
        {
            public AddBookWindow()
            {
                InitializeComponent();
            DepartmentComboBox.ItemsSource = DBcon.library.Departments.ToList();
            DepartmentComboBox.DisplayMemberPath = "DepartmentName";
            DepartmentComboBox.SelectedValuePath = "ID";
        }

        private void SaveButton_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                var newBook = new Books // Используем Book вместо Books, если это имя класса
                {
                    Title = TitleTextBox.Text,
                    Author = AuthorTextBox.Text,
                    PublicationYear = int.TryParse(YearTextBox.Text, out var year) ? year : (int?)null,
                    DepartmentID = (int?)DepartmentComboBox.SelectedValue
                };

                DBcon.library.Books.Add(newBook);
                DBcon.library.SaveChanges();
                DialogResult = true;
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка при сохранении: {ex.Message}");
                DialogResult = false;
            }
            Close();
        }

        private void CancelButton_Click(object sender, RoutedEventArgs e)
        {
            DialogResult = false;
            Close();
        }
    }
}

