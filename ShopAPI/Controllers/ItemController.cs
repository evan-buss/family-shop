using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using System.Security.Claims;

using ShopApi.Services;

using ShopApi.Models;
using ShopApi.Models.Database;
using System;


namespace ShopApi.Controllers
{
    // Manages adding, removing, and changing items within family lists
    [Authorize]
    [Route("api/[controller]")]
    public class ItemController : ControllerBase
    {
        private readonly FamilyShopContext _context;
        private readonly ItemService _service;

        public ItemController(FamilyShopContext context)
        {
            _context = context;
            _service = new ItemService(_context);
        }

        // GET all items in a specific list
        [HttpGet("{listID}")]
        public ActionResult<List<Models.Public.Response.Item>> GetListItem(long listID, [FromQuery] long? itemID)
        {

            if (itemID.HasValue)
            {
                var item = _service.GetListItem(listID, itemID, getID());
                if (item != null)
                {
                    return new ObjectResult(item);
                }
                return NotFound();
            }
            else
            {
                var list = _service.GetListItems(listID, getID());
                if (list != null)
                {
                    return new ObjectResult(list);
                }
                return NotFound();
            }
        }

        // POST api/personal
        [HttpPost]
        public async Task<ActionResult<Models.Public.Response.Item>> PostListItem([FromBody] Models.Public.Request.Item item)
        {

            var newItem = await _service.AddPersonalItem(item, getID());
            if (newItem != null)
            {
                return new CreatedResult("/api/item/" + newItem.itemID, newItem);
            }
            return BadRequest();
        }

        // DELETE api/item/5
        [HttpDelete("{itemID}")]
        public async Task<IActionResult> DeleteListItem(long itemID)
        {
            var listItem = await _context.ListItems.FindAsync(itemID);

            if (listItem == null)
            {
                return NotFound();
            }

            _context.ListItems.Remove(listItem);

            await _context.SaveChangesAsync();

            return NoContent();
        }

        private long getID()
        {
            return long.Parse(User.FindFirst(ClaimTypes.NameIdentifier)?.Value);
        }
    }
}