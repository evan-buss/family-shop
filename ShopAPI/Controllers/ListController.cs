using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using System.Security.Claims;

using ShopApi.Services;

using ShopApi.Models;

// ListController handles high level list managment. Creating, Deletion, Updating the list as a WHOLE
namespace ShopApi.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    public class ListController : ControllerBase
    {
        private readonly FamilyShopContext _context;
        private readonly ListService _service;


        public ListController(FamilyShopContext context)
        {
            _context = context;
            _service = new ListService(_context);
        }

        [HttpGet]
        public ActionResult<List<Models.Public.Response.ListMetadata>> GetLists()
        {
            var lists = _service.GetLists(getID());

            if (lists != null)
            {
                return new ObjectResult(lists);
            }
            return BadRequest();
        }

        [HttpPost]
        public async Task<ActionResult> CreateList([FromBody] Models.Public.Request.List list)
        {
            var success = await _service.CreateList(list, getID());
            if (success)
            {
                return Ok();
            }
            return BadRequest();
        }

        [HttpDelete("{listID}")]
        public async Task<ActionResult> DeleteList(long listID)
        {
            var success = await _service.DeleteList(listID, getID());
            if (success)
            {
                return Ok();
            }
            return BadRequest();
        }

        private string getID()
        {
            return User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        }
    }
}