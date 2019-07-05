using Microsoft.EntityFrameworkCore;


namespace ShopApi.Models
{
    public class FamilyShopContext : DbContext
    {

        public FamilyShopContext(DbContextOptions<FamilyShopContext> options) : base(options) 
        {

        }

         public DbSet<ListItem> ListItems { get; set; }
        
    }
}