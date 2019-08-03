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

        public IEnumerable<ShopApi.Models.Private.User> GetMembers(string id)
        {
            var user = _context.Users.Find(long.Parse(id));
            if (user != null)
            {
                return _context.Families.Where(q => q.members.Contains(user)).FirstOrDefault().members;
            }
            return null;
        }

        // Create a new family with the given data and set the user as the family admin
        public async Task<bool> CreateFamily(string id, string familyName)
        {
            var user = _context.Users.Find(long.Parse(id));
            // User was found and user doesn't already have a family
            if (user != null)
            {
                // Create a new family with the given details
                var family = new Models.Private.Family
                {
                    admin = user,
                    name = familyName,
                    members = new List<Models.Private.User>{
                        user
                    }
                };
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
        public ShopApi.Models.Public.Response.Family GetFamily(string id)
        {
            var user = _context.Users.Find(long.Parse(id));
            var privateFam = _context.Families.Where(q => q.members.Contains(user)).FirstOrDefault();
            var response = new Models.Public.Response.Family
            {
                familyID = privateFam.familyID,
                name = privateFam.name,
                admin = new Models.Public.Response.User
                {
                    userID = privateFam.admin.userID,
                    username = privateFam.admin.username
                },
                members = new List<Models.Public.Response.User>(privateFam.members.Select(x =>
                    new Models.Public.Response.User
                    {
                        userID = x.userID,
                        username = x.username
                    }))
            };

            return response;
        }
    }
}