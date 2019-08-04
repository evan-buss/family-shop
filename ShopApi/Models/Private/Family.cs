using System.ComponentModel.DataAnnotations;
using System.Collections.Generic;
using System.Linq;

namespace ShopApi.Models.Private
{
    public class Family
    {
        [Key]
        public long familyID { get; set; }
        public string name { get; set; }
        public virtual User admin { get; set; }
        public virtual ICollection<User> members { get; set; }
        public virtual ICollection<List> lists { get; set; }

        public Models.Public.Response.Family toPublic()
        {
            var publicFam = new Models.Public.Response.Family
            {
                familyID = this.familyID,
                name = this.name,
                admin = new Models.Public.Response.User
                {
                    userID = this.admin.userID,
                    username = this.admin.username
                },
                members = new List<Models.Public.Response.User>(this.members.Select(x =>
                    new Models.Public.Response.User
                    {
                        userID = x.userID,
                        username = x.username
                    }))
            };

            return publicFam;
        }
    }
}