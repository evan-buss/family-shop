using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Threading.Tasks;
using System;
using Microsoft.AspNetCore.Authorization;
using System.Security.Claims;

using ShopApi.Services;

using ShopApi.Models;
using ShopApi.Models.Private;


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
        public async Task<ActionResult<IEnumerable<ListItem>>> GetListItems()
        {
            Console.WriteLine(User.FindFirst(ClaimTypes.NameIdentifier)?.Value);
            return await _context.ListItems.ToListAsync();
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
        public async Task<ActionResult<IEnumerable<ListItem>>> PostListItem([FromBody] Models.Public.Item item)
        {
            Models.Public.Response.Item newItem = await _service.AddPersonalItem(item, User.FindFirst(ClaimTypes.NameIdentifier)?.Value);
            
            return CreatedAtAction(nameof(GetListItem), new { id = newItem.itemID }, newItem);
        }

        // DELETE api/personal/3Item
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteListItem(long id)
        {
            var listItem = await _context.ListItems.FindAsync(id);

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