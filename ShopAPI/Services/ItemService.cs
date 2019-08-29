using System.Linq;
using System.Collections.Generic;
using System.Threading.Tasks;

using ShopApi.Models;

namespace ShopApi.Services
{
  public class ItemService
  {

    private readonly FamilyShopContext _context;

    public ItemService(FamilyShopContext context)
    {
      _context = context;
    }

    public Models.Public.Response.List GetListItems(long listID, long userID)
    {
      var user = _context.Users.Find(userID);
      var family = _context.Families.Where(q => q.members.Contains(user)).FirstOrDefault();

      if (family != null)
      {
        var list = family.lists.Where(q => q.listID == listID).FirstOrDefault();
        if (list != null)
        {
          return list.ToPublic();
        }
      }
      return null;
    }

    public Models.Public.Response.Item GetListItem(long listID, long? itemID, long userID)
    {
      var user = _context.Users.Find(userID);
      var family = _context.Families.Where(q => q.members.Contains(user)).FirstOrDefault();

      if (family != null)
      {
        var list = family.lists.Where(q => q.listID == listID).FirstOrDefault();
        if (list != null)
        {
          return list.items.Where(item => item.itemID == itemID).FirstOrDefault().ToPublic();
        }
      }
      return null;
    }

    public async Task<Models.Public.Response.Item> AddPersonalItem(Models.Public.Request.Item item, long userID)
    {
      var user = _context.Users.Find(userID);
      var family = _context.Families.Where(q => q.members.Contains(user)).FirstOrDefault();
      if (family != null)
      {
        var list = family.lists.Where(q => q.listID == item.listID).FirstOrDefault();
        if (list != null)
        {
          var dbItem = item.ToDatabase(user, list);
          _context.ListItems.Add(dbItem);
          await _context.SaveChangesAsync();
          return new Models.Public.Response.Item
          {
            itemID = dbItem.itemID,
            title = dbItem.title,
            description = dbItem.description,
            image = dbItem.image
          };
        }
      }
      return null;
    }
  }
}