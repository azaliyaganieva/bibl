//------------------------------------------------------------------------------
// <auto-generated>
//     Этот код создан по шаблону.
//
//     Изменения, вносимые в этот файл вручную, могут привести к непредвиденной работе приложения.
//     Изменения, вносимые в этот файл вручную, будут перезаписаны при повторном создании кода.
// </auto-generated>
//------------------------------------------------------------------------------

namespace bibl.Connect
{
    using System;
    using System.Collections.Generic;
    
    public partial class Abonement
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Abonement()
        {
            this.BookVidacha = new HashSet<BookVidacha>();
        }
    
        public int ID { get; set; }
        public Nullable<int> ReaderID { get; set; }
        public Nullable<System.DateTime> OpeningDate { get; set; }
    
        public virtual Readers Readers { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<BookVidacha> BookVidacha { get; set; }
    }
}
