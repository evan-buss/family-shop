namespace ShopApi.Models.Public.Response
{
    // Response to creating a new list item. Contains the itemID
    public class Item
    {
        public long itemID { get; set; }
        public string title { get; set; }
        public string description { get; set; }

        public static Item fromListItem(Models.Private.ListItem item)
        {
            return new Item { itemID = item.itemID, title = item.title, description = item.description };
        }
    }
}