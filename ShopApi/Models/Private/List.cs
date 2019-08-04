namespace ShopApi.Models.Private
{
    public class List
    {
        public long listID { get; set; } 
        public string name { get; set; }
        public string description { get; set; }
        public virtual Family family { get; set; }
    }
}