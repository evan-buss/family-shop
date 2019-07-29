namespace ShopApi.Models.Private
{
    public class List
    {
        public long ListID { get; set; } 
        public string name { get; set; }
        public string description { get; set; }
        public Family family { get; set; }
    }
}