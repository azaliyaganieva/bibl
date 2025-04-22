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
    /// Логика взаимодействия для Autorizatoin.xaml
    /// </summary>
    public partial class Autorizatoin : Page
    {
        public Autorizatoin()
        {
            InitializeComponent();
        }
        private void btnVhod_Click(object sender, RoutedEventArgs e)
        {
            string login = loginTxb.Text.Trim();
            string password = parolTxb.Password;

            if (string.IsNullOrEmpty(login) || string.IsNullOrEmpty(password))
            {
                MessageBox.Show("Введите логин и пароль");
                return;
            }

            try
            {
                // Проверка сотрудника в базе данных
                var employee = DBcon.library.Employees
                    .FirstOrDefault(emp => emp.FullName == login && emp.PasswordHash == password);

                if (employee != null)
                {
                    // Переход на главную страницу после успешной авторизации
                    NavigationService.Navigate(new MainPage());
                }
                else
                {
                    MessageBox.Show("Неверный логин или пароль");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка авторизации: {ex.Message}");
            }
        }
    
}
}
