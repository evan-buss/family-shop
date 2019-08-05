using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Threading.Tasks;
using System;
using Microsoft.AspNetCore.Authorization;
using System.Security.Claims;

using ShopApi.Services;

using ShopApi.Models;
using ShopApi.Models.Database;


namespace ShopApi.Controllers
{
    // Personal controller retrieves your own list items.
    [Authorize]
    [Route("api/[controller]")]
    public class PersonalController : ControllerBase
    {
        private readonly FamilyShopContext _context;
        private readonly PersonalService _service;


        public PersonalController(FamilyShopContext context)
        {
            _context = context;
            _service = new PersonalService(_context);
        }

        // GET api/personal
        [HttpGet]
        public ActionResult<List<Models.Public.Response.Item>> GetListItems()
        {
            string user = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
            return new ObjectResult(_service.GetPersonalItems(user));
        }

        // GET api/personal/2
        [HttpGet("{id}")]
        public async Task<ActionResult<ListItem>> GetListItem(long id)
        {
            var item = await _context.ListItems.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            return item;
        }

        // POST api/personal
        [HttpPost]
        public async Task<ActionResult<IEnumerable<ListItem>>> PostListItem([FromBody] Models.Public.Request.Item item)
        {
            Models.Public.Response.Item newItem = await _service.AddPersonalItem(item, User.FindFirst(ClaimTypes.NameIdentifier)?.Value);

            return CreatedAtAction(nameof(GetListItem), new { id = newItem.itemID }, newItem);
        }

        // DELETE api/personal/Item
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
    }
}