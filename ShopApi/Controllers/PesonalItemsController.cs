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
    public class PersonalItemController : ControllerBase
    {
        private readonly FamilyShopContext _context;

        public PersonalItemController(FamilyShopContext context)
        {
            _context = context;


            if (_context.ListItems.Count() == 0)
            {
                _context.ListItems.Add(new ListItem ());
                _context.SaveChanges();
            }
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<ListItem>>> GetListItems()
        {
            return await _context.ListItems.ToListAsync();
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteListItem(long id) {
            var listItem = await _context.ListItems.FindAsync(id);

            if (listItem == null) {
                return NotFound();
            }

            _context.ListItems.Remove(listItem);

            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}