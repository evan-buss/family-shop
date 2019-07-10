using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;


namespace ShopApi.Models
{
    public class User
    {
        public string username { get; set; }
        [Key]
        public string email { get; set; }
        public string passwordHash { get; set; }
        public byte[] passwordSalt { get; set; }
        [ForeignKey("familyID")]
        public Family family { get; set; }

        public User() { }
    }
}