using System.ComponentModel.DataAnnotations;
using System.Collections.Generic;

namespace ShopApi.Models.Public.Response
{
    public class Family
    {
        [Key]
        public long familyID { get; set; }
        public string name { get; set; }
        public Models.Public.Response.User admin { get; set; }
        public ICollection<Models.Public.Response.User> members { get; set; }
    }
}