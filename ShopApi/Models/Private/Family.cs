using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Collections.Generic;

namespace ShopApi.Models.Private
{
    public class Family
    {
        [Key]
        public long familyID { get; set; }
        public string name { get; set; }
        // Admin is the "head" of the family that manages their lists

        // public long adminID { get; set; }

        [ForeignKey("adminID")]
        public User admin { get; set; }
        public ICollection<List> lists { get; set; }
    }
}