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
    /// Логика взаимодействия для AddEditBookWindow.xaml
    /// </summary>
    public partial class AddEditBookWindow : Window
    {
       
            public AddEditBookWindow()
            {
                InitializeComponent();
            }

            private void SaveButton_Click(object sender, RoutedEventArgs e)
            {
                // Реализация сохранения
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

