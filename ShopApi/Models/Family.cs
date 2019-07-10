using System.ComponentModel.DataAnnotations.Schema;
using System.Collections.Generic;

namespace ShopApi.Models
{
    public class Family
    {
        public long familyID { get; set; }
        public string name { get; set; }
        // Admin is the "head" of the family that manages their lists
        public string adminID { get; set; }
        public ICollection<List> lists { get; set; }
    }
}