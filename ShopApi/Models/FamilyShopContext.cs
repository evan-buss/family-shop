using Microsoft.EntityFrameworkCore;

namespace ShopApi.Models
{
    // Context handles databse access to the various tables
    public class FamilyShopContext : DbContext
    {
        public FamilyShopContext(DbContextOptions<FamilyShopContext> options) : base(options) { }

        public DbSet<Private.User> Users { get; set; }
        public DbSet<Private.Family> Families { get; set; }
        public DbSet<Private.List> Lists { get; set; }
        public DbSet<Private.ListItem> ListItems { get; set; }
        // public DbSet<Comment> Comments { get; set; }
    }
}