using System.Collections.Generic;

namespace ShopApi.Models
{
    public class Family
    {
        public long familyID { get; set; }
        public string name { get; set; }

        public ICollection<List> lists { get; set; }
    }
}