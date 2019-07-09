using Microsoft.EntityFrameworkCore;


namespace ShopApi.Models
{
    // Context handles databse access to the various tables
    public class FamilyShopContext : DbContext
    {
        public FamilyShopContext(DbContextOptions<FamilyShopContext> options) : base(options) { }

        public DbSet<User> Users { get; set; }
        public DbSet<Family> Families { get; set; }
        public DbSet<List> Lists { get; set; }
        public DbSet<ListItem> ListItems { get; set; }
        // public DbSet<Comment> Comments { get; set; }
    }
}