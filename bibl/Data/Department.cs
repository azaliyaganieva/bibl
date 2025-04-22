using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using bibl.Connect;

namespace bibl.Data
{
    
    
        [Table("Departments")] // Соответствует вашей таблице в БД
        public class Departments
        {
            [Key]
            public int ID { get; set; }

            [Required]
            [StringLength(255)]
            public string DepartmentName { get; set; }

            // Навигационное свойство для связи с книгами
            public virtual ICollection<Books> Books { get; set; }
        }
    
}
