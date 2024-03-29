using System.Collections.Generic;

namespace ShopApi.Models.Public.Response
{
    public class Family
    {
        public long familyID { get; set; }
        public string name { get; set; }
        public Models.Public.Response.User admin { get; set; }
        public ICollection<Models.Public.Response.User> members { get; set; }
        public ICollection<Models.Public.Response.List> lists { get; set; }
    }
}