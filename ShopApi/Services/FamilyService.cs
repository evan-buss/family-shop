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

        // Create a new family with the given data and set the user as the family admin
        public async Task<bool> CreateFamily(string id, string familyName)
        {
            var user = _context.Users.Find(long.Parse(id));
            // User was found and user doesn't already have a family
            if (user != null)
            {
                // Create a new family with the given details
                var family = new Models.Database.Family
                {
                    admin = user,
                    name = familyName,
                    members = new List<Models.Database.User>()
                };

                family.members.Add(user);
                // Save the family to the Families table
                _context.Families.Add(family);
                // Update the user's family
                await _context.SaveChangesAsync();
                return true;
            }
            return false;
        }

        // Retrieve all details about the user's family. 
        // Basically converts the private model to the public model and returns it.
        public Models.Public.Response.Family GetFamily(string id)
        {
            var user = _context.Users.Find(long.Parse(id));
            var family = _context.Families.Where(q => q.members.Contains(user)).FirstOrDefault();

            if (family != null)
            {
                return family.toPublic();
            }
            return null;

        }

        public async Task<Models.Public.Response.Family> JoinFamily(long familyID, string userID)
        {
            var user = _context.Users.Find(long.Parse(userID));
            var family = _context.Families.Find(familyID);
            if (family != null)
            {
                family.members.Add(user);
                _context.Families.Update(family);
                await _context.SaveChangesAsync();
                return family.toPublic();
            }
            return null;
        }

        public async Task<bool> LeaveFamily(string userID)
        {
            var user = _context.Users.Find(long.Parse(userID));
            var family = _context.Families.Where(q => q.members.Contains(user)).FirstOrDefault();

            if (family != null)
            {
                family.members.Remove(user);
                _context.Families.Update(family);
                await _context.SaveChangesAsync();
                return true;
            }
            return false;
        }
    }
}