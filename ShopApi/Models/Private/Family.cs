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
        public User admin { get; set; }
        public ICollection<User> members { get; set; }
        public ICollection<List> lists { get; set; }
    }
}