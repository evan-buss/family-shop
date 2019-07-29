using System;
using System.Linq;
using System.Collections.Generic;
using System.Threading.Tasks;

using ShopApi.Models;

namespace ShopApi.Services
{
    public class PersonalService
    {

        private readonly FamilyShopContext _context;

        public PersonalService(FamilyShopContext context)
        {
            _context = context;
        }

        public IEnumerable<Models.Public.Response.Item> GetPersonalItems(string id)
        {
            var list = _context.ListItems.Where(q => q.userID == long.Parse(id)).ToList();
            var response = new List<Models.Public.Response.Item>();
            // Convert from the database representation to the public view representation of the items
            foreach (Models.Private.ListItem item in list)
            {
                response.Add(Models.Public.Response.Item.fromListItem(item));
            }
            return response;
        }

        public async Task<Models.Public.Response.Item> AddPersonalItem(Models.Public.Item item, string id)
        {
            Models.Private.ListItem newItem = new Models.Private.ListItem();
            newItem.title = item.title;
            newItem.description = item.description;
            newItem.user = await _context.Users.FindAsync(long.Parse(id));

            _context.ListItems.Add(newItem);
            await _context.SaveChangesAsync();

            return new Models.Public.Response.Item
            {
                title = newItem.title,
                description = newItem.description,
                itemID = newItem.itemID
            };
        }
    }
}