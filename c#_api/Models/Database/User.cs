using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;


namespace ShopApi.Models.Database
{
    public class User
    {
        [Key]
        public long userID { get; set; }
        public string username { get; set; }
        public string email { get; set; }
        public string passwordHash { get; set; }
        public byte[] passwordSalt { get; set; }

        public Models.Public.Response.User ToPublic()
        {
            return new Models.Public.Response.User
            {
                userID = this.userID,
                username = this.username
            };
        }
    }
}