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

        public async Task<Models.Public.Response.Item> AddPersonalItem(Models.Public.Item item, string email)
        {
            Models.Private.ListItem newItem = new Models.Private.ListItem();
            newItem.title = item.title;
            newItem.description = item.description;
            newItem.user = await _context.Users.FindAsync(email);

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