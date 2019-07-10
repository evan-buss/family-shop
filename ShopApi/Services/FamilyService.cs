using ShopApi.Models;
using System.Collections.Generic;
using System.Threading.Tasks;
using System.Linq;

namespace ShopApi.Services
{
    public class FamilyService
    {

        private readonly FamilyShopContext _context;

        public FamilyService(FamilyShopContext context)
        {
            _context = context;
        }

        public IEnumerable<User> GetMembers(string email)
        {
            var user = _context.Users.Where(q => q.email == email).FirstOrDefault();
            if (user != null)
            {
                return _context.Users.Where(q => q.family.familyID == user.family.familyID).ToList();
            }
            return null;
        }
    }
}