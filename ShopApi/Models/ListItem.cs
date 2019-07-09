using System.ComponentModel.DataAnnotations;

namespace ShopApi.Models
{
    // ListItem represents an individual item in a user's list
    public class ListItem
    {
        [Key]
        public long itemID { get; set; }
        public string title { get; set; }
        public string description { get; set; }
        public List list { get; set; }
        public User user { get; set; }
        public ListItem() { }
    }
}