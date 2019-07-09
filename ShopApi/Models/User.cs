using System.ComponentModel.DataAnnotations;

namespace ShopApi.Models
{
    public class User
    {
        public string username { get; set; }
        [Key]
        public string email { get; set; }
        public string passwordHash { get; set; }
        public byte[] passwordSalt { get; set; }

        public Family family { get; set; }

        public User() { }
    }
}