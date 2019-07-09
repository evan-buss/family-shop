using ShopApi.Models;

namespace ShopApi.Services
{
    public class FamilyService
    {

        private readonly FamilyShopContext _context;

        public FamilyService(FamilyShopContext context) 
        {
            _context = context;
        }
    }
}