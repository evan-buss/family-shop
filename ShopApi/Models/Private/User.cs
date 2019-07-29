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

        public long familyId { get; set; }

        [ForeignKey("familyID")]
        public Family family { get; set; }
    }
}