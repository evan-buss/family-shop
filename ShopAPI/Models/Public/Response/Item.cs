namespace ShopApi.Models.Public.Response
{
  // Response to creating a new list item. Contains the itemID
  public class Item
  {
    public long itemID { get; set; }
    public string title { get; set; }
    public string description { get; set; }
    public byte[] image { get; set; }
  }
}