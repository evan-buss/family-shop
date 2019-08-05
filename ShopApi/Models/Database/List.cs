using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;

namespace ShopApi.Models.Database
{
    public class List
    {
        [Key]
        public long listID { get; set; }
        public string title { get; set; }
        public string description { get; set; }
        public virtual ICollection<ListItem> items { get; set; }

        public Models.Public.Response.List ToPublic()
        {
            return new Models.Public.Response.List
            {
                listID = this.listID,
                title = this.title,
                description = this.description,
                items = new List<Models.Public.Response.Item>(this.items.Select(x =>
                {
                    return x.ToPublic();
                }))
            };
        }

        public Models.Public.Response.ListMetadata GetMetadata()
        {
            return new Models.Public.Response.ListMetadata
            {
                listID = this.listID,
                title = this.title,
                description = this.description
            };
        }
    }
}