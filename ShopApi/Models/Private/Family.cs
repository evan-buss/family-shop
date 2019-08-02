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
        // TODO: Figure out this User -> Family  and Family -> User relationship...
        public User admin { get; set; }
        public ICollection<List> lists { get; set; }
    }
}