using System.Collections.Generic;

namespace ShopApi.Models.Public.Response
{
    public class List
    {
        public long listID { get; set; }
        public string title { get; set; }
        public string description { get; set; }
        public ICollection<Models.Public.Response.Item> items { get; set; }
    }
}