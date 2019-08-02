using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;


namespace ShopApi.Models.Private
{
    public class User
    {
        [Key]
        public long userID { get; set; }
        public string username { get; set; }
        public string email { get; set; }
        public string passwordHash { get; set; }
        public byte[] passwordSalt { get; set; }
        // This is a hacky way to get an optional foreign key.
        // I will have to manually use it to retrieve the associated family
        public long familyID { get; set; }
    }
}