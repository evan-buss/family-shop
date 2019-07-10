using System;
using System.Linq;
using System.Collections.Generic;
using System.Threading.Tasks;

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

        public IEnumerable<User> GetMembers(string email)
        {
            var user = _context.Users.Where(q => q.email == email).FirstOrDefault();
            if (user != null)
            {
                return _context.Users.Where(q => q.family.familyID == user.family.familyID).ToList();
            }
            return null;
        }

        // Create a new family with the given data and set the user as the family admin
        public async Task<bool> CreateFamily (string email, string familyName)
        {   
            var user = _context.Users.Find(email);
            // User was found and user doesn't already have a family
            if (user != null && user.family == null) 
            {
                var family = new Family { adminID = user.email, name = familyName};
                _context.Add(family);
                user.family = family;
                await _context.SaveChangesAsync();
                return true;
            }
            
            return false;
        }

        public Family GetFamily(string email) 
        {
            return _context.Users.Find(email)?.family;
        }
    }
}