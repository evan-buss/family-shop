using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ShopApi.Models.Database
{
  // ListItem represents an individual item in a user's list
  public class ListItem
  {
    [Key]
    public long itemID { get; set; }
    public string title { get; set; }
    public string description { get; set; }
    public byte[] image { get; set; }
    public virtual List list { get; set; }
    public virtual User user { get; set; }


    public Models.Public.Response.Item ToPublic()
    {
      return new Models.Public.Response.Item
      {
        itemID = this.itemID,
        title = this.title,
        description = this.description,
        image = this.image
      };
    }
  }
}