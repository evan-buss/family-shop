using Microsoft.EntityFrameworkCore;


namespace ShopApi.Models
{
    // Context handles databse access to the various tables
    public class FamilyShopContext : DbContext
    {
        public FamilyShopContext(DbContextOptions<FamilyShopContext> options) : base(options) { }

        public DbSet<ListItem> ListItems { get; set; }
        public DbSet<User> Users { get; set; }
    }
}