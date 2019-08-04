using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ShopApi.Models.Private
{
    // ListItem represents an individual item in a user's list
    public class ListItem
    {
        [Key]
        public long itemID { get; set; }
        public string title { get; set; }
        public string description { get; set; }
        public virtual List list { get; set; }

        public long userID { get; set;}

        [ForeignKey("userID")]
        public virtual User user { get; set; }
    }
}