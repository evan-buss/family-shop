using System.ComponentModel.DataAnnotations;

namespace ShopApi.Models
{
    public class ListItem
    {
        [Key]
        public long itemID { get; set; }

        public string title { get; set; }

        public string description { get; set; }

        public long userID { get; set; }

        public ListItem () {
            title = "Default Title";
            description = "Default Description";
            userID = 28;
        }
    }
}