using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using ShopApi.Models;


namespace ShopApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PersonalController : ControllerBase
    {
        private readonly FamilyShopContext _context;

        public PersonalController(FamilyShopContext context)
        {
            _context = context;
        }

        // GET api/personal
        [HttpGet]
        public async Task<ActionResult<IEnumerable<ListItem>>> GetListItems()
        {
            return await _context.ListItems.ToListAsync();
        }

        // GET api/personal/2
        [HttpGet("{id}")]
        public async Task<ActionResult<ListItem>> GetListItem(long id)
        {
            var item = await _context.ListItems.FindAsync(id);
            
            if (item == null) {
                return NotFound();
            }

            return item;
        }
        
        // POST api/personal
        [HttpPost]
        public async Task<ActionResult<IEnumerable<ListItem>>> PostListItem(ListItem item)
        {
            _context.ListItems.Add(item);
            await _context.SaveChangesAsync();
            
            return CreatedAtAction(nameof(GetListItem), new { id = item.itemID }, item);
        }

        // DELETE api/personal/3
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