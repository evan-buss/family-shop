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

        // public IEnumerable<ShopApi.Models.Private.User> GetMembers(string email)
        // {
        //     var user = _context.Users.Where(q => q.email == email).FirstOrDefault();
        //     if (user != null)
        //     {
        //         return _context.Users.Where(q => q.family.familyID == user.family.familyID).ToList();
        //     }
        //     return null;
        // }

        // Create a new family with the given data and set the user as the family admin
        public async Task<bool> CreateFamily(string id, string familyName)
        {
            var user = _context.Users.Find(long.Parse(id));
            // User was found and user doesn't already have a family
            if (user != null)
            {
                // Create a new family with the given details
                var family = new Models.Private.Family { admin = user, name = familyName };
                // Save the family to the Families table
                _context.Families.Add(family);
                // Update the user's family
                user.familyID = family.familyID;
                _context.Users.Update(user);
                await _context.SaveChangesAsync();
                return true;
            }

            return false;
        }

        public ShopApi.Models.Private.Family GetFamily(string id)
        {
            var familyID = _context.Users.Find(long.Parse(id))?.familyID;
            var family = _context.Families.Find(familyID);
            Console.WriteLine("FamID:" + familyID);
            Console.WriteLine("fam:" + family);
            return family;
        }
    }
}