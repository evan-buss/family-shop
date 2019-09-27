using System.Linq;
using System.Collections.Generic;
using System.Threading.Tasks;
using System;

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

    public Models.Public.Response.List GetItems(long listID, long userID)
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

    public Models.Public.Response.Item GetItem(long listID, long? itemID, long userID)
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

    public async Task<Models.Public.Response.Item> AddItem(Models.Public.Request.Item item, long userID)
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
          return dbItem.ToPublic();
        }
      }
      return null;
    }
    public async Task<Models.Public.Response.Item> UpdateItem(Models.Public.Request.Item item, long userID)
    {
      var user = _context.Users.Find(userID);
      var family = _context.Families.Where(q => q.members.Contains(user)).FirstOrDefault();
      Console.WriteLine("ITEM ID: " + item.itemID);
      Console.WriteLine("ITEM title: " + item.title);
      Console.WriteLine("ITEM desc: " + item.description);
      var existingItem = _context.ListItems.Where(q => q.itemID == item.itemID).FirstOrDefault();
      if (existingItem != null)
      {
        Console.WriteLine("Existing Item not null");
        var list = family.lists.Where(q => q.listID == item.listID).FirstOrDefault();
        if (list != null)
        {
          // FIXME: The existing item isn't being updated, rather a new item is being created...
          existingItem = item.ToDatabase(user, list);
          _context.ListItems.Update(existingItem);
          await _context.SaveChangesAsync();

          return existingItem.ToPublic();
        }
      }
      Console.WriteLine("Something failed");
      return null;
    }
  }
}