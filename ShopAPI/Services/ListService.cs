using System.Linq;
using System.Collections.Generic;
using System.Threading.Tasks;

using ShopApi.Models;

namespace ShopApi.Services
{
    public class ListService
    {
        private readonly FamilyShopContext _context;

        public ListService(FamilyShopContext context)
        {
            _context = context;
        }

        // public Models.Public.Response.List GetList(long listID, string userID)
        // {
        //     var user = _context.Users.Find(long.Parse(userID));
        //     var family = _context.Families.Where( q => q.members.Contains(user)).FirstOrDefault();
        //     if (family != null)
        //     {
        //         var list = family.lists.Where(q => q.listID == listID).FirstOrDefault();
        //         if (list != null)
        //         {
        //             return list.ToPublic();
        //         }
        //     }
        //     return null;
        // }

        // Return the list details excluding the items.
        public List<Models.Public.Response.ListMetadata> GetLists(string userID)
        {
            var user = _context.Users.Find(long.Parse(userID));
            var family = _context.Families.Where(q => q.members.Contains(user)).FirstOrDefault();

            if (family != null)
            {
                return new List<Models.Public.Response.ListMetadata>(family.lists.Select(x => x.GetMetadata()));
            }
            return null;
        }

        public async Task<Models.Public.Response.ListMetadata> CreateList(Models.Public.Request.List list, string userID)
        {
            var user = _context.Users.Find(long.Parse(userID));
            var family = _context.Families.Where(q => q.members.Contains(user)).FirstOrDefault();
            if (family != null)
            {
                var dbList = new Models.Database.List { title = list.title, description = list.description };
                family.lists.Add(dbList);
                _context.Families.Update(family);
                await _context.SaveChangesAsync();
                return dbList.GetMetadata();
            }
            return null;
        }

        // Remove a list by its listID
        // NOTE: Need to ensure that the user is a member of the list
        // FUTURE: May make it so that only the family admin can add or delete lists in the family
        public async Task<bool> DeleteList(long listID, string userID)
        {
            var user = _context.Users.Find(long.Parse(userID));
            var family = _context.Families.Where(q => q.members.Contains(user)).FirstOrDefault();
            if (family != null)
            {
                // Search the family for the listID to ensure that they are allowed to delete it
                var doomedList = family.lists.Where(q => q.listID == listID).FirstOrDefault();
                if (doomedList != null)
                {
                    // Delete the list if found in the user's family lists
                    family.lists.Remove(doomedList);
                    _context.Families.Update(family);
                    await _context.SaveChangesAsync();
                    return true;
                }
            }
            return false;
        }
    }
}