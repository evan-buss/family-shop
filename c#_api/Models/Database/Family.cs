using System.ComponentModel.DataAnnotations;
using System.Collections.Generic;
using System.Linq;

namespace ShopApi.Models.Database
{
    public class Family
    {
        [Key]
        public long familyID { get; set; }
        public string name { get; set; }
        public virtual User admin { get; set; }
        public virtual ICollection<User> members { get; set; }
        public virtual ICollection<List> lists { get; set; }

        // Convert the database family model to a public family model with private data removed.
        public Models.Public.Response.Family toPublic()
        {
            var publicFam = new Models.Public.Response.Family
            {
                familyID = this.familyID,
                name = this.name,
                admin = admin.ToPublic(),
                members = new List<Models.Public.Response.User>(this.members.Select(x =>
                    x.ToPublic()
                )),
                // Return the public model for each list in the family
                lists = new List<Models.Public.Response.List>(this.lists.Select(x =>
                    x.ToPublic()
                ))
            };

            return publicFam;
        }
    }
}