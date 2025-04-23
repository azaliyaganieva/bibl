using bibl.Connect;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Remoting.Messaging;
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
using System.Data.Entity; // Добавьте эту директиву
using bibl.Data; // Добавьте директиву для ваших моделей

namespace bibl.Windows
{
    public partial class AddLoanWindow : Window
    {
        private int? _bookId; // Используем nullable int

        public AddLoanWindow(int? bookId = null)
        {
            InitializeComponent();
            _bookId = bookId;
            LoadData();
        }

        private void LoadData()
        {
            BooksComboBox.ItemsSource = DBcon.library.Books.ToList();
            ReadersComboBox.ItemsSource = DBcon.library.Readers.ToList();

            if (_bookId != null) // Проверяем на null вместо HasValue
            {
                BooksComboBox.SelectedValue = _bookId;
                BooksComboBox.IsEnabled = false;
            }

            IssueDatePicker.SelectedDate = DateTime.Today;
        }

        private void SaveButton_Click(object sender, RoutedEventArgs e)
        {
            if (BooksComboBox.SelectedItem == null || ReadersComboBox.SelectedItem == null)
            {
                MessageBox.Show("Выберите книгу и читателя");
                return;
            }

            if (ReturnDatePicker.SelectedDate == null || ReturnDatePicker.SelectedDate < IssueDatePicker.SelectedDate)
            {
                MessageBox.Show("Дата возврата должна быть позже даты выдачи");
                return;
            }

            var loan = new BookVidacha
            {
                BookID = (int)BooksComboBox.SelectedValue,
                SubscriptionID = ((Readers)ReadersComboBox.SelectedItem).ID,
                LoanDate = IssueDatePicker.SelectedDate.Value,
                ReturnDate = ReturnDatePicker.SelectedDate.Value, // Добавляем дату возврата
                EmployeeID = 1
            };

            DBcon.library.BookVidacha.Add(loan);
            DBcon.library.SaveChanges();
            DialogResult = true;
            Close();
        }

        private void CancelButton_Click(object sender, RoutedEventArgs e)
        {
            DialogResult = false;
            Close();
        }
    }
}