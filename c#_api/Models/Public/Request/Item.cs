namespace ShopApi.Models.Public.Request
{
  // Request to create a new list item.
  public class Item
  {
    public long itemID { get; set; }
    public long listID { get; set; }
    public string title { get; set; }
    public string description { get; set; }

    public byte[] image { get; set; }

    public Models.Database.ListItem ToDatabase(Models.Database.User user, Models.Database.List list)
    {
      return new Models.Database.ListItem
      {
        title = this.title,
        description = this.description,
        user = user,
        list = list,
        image = this.image
      };
    }
  }
}