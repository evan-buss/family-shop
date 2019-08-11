using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using System.Threading.Tasks;
using System.Collections.Generic;
using System.Security.Claims;
using System;


using ShopApi.Models;
using ShopApi.Models.Database;
using ShopApi.Services;

// Future:
//  - Change family owner
//  - Delete family entirely
namespace ShopApi.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    public class FamilyController : ControllerBase
    {
        private readonly FamilyShopContext _context;
        private readonly FamilyService _service;

        public FamilyController(FamilyShopContext context)
        {
            _context = context;
            _service = new FamilyService(_context);
        }

        // TODO: Allow family deletion
        // 

        // Return all details of the user's current family
        [HttpGet]
        public ActionResult<Models.Public.Response.Family> GetFamily()
        {
            var family = _service.GetFamily(getID());
            if (family != null)
            {
                return family;
            }
            return NotFound();
        }

        [HttpGet("users")]
        public ActionResult<List<Models.Public.Response.User>> GetUsers()
        {
            var users = _service.GetUsers(getID());
            if (users != null)
            {
                return users;
            }
            return NotFound();
        }

        [HttpPost]
        public async Task<IActionResult> CreateFamily([FromBody] string name)
        {
            Console.WriteLine("Name: " + name);
            var success = await _service.CreateFamily(getID(), name);
            if (success)
            {
                return Ok();
            }

            return BadRequest();
        }

        // Join an existing family
        [HttpPut("{familyID}")]
        public async Task<ActionResult<Models.Public.Response.Family>> JoinFamily(long familyID)
        {
            var family = await _service.JoinFamily(familyID, getID());
            if (family != null)
            {
                return family;
            }
            return NotFound();
        }

        [HttpDelete]
        public async Task<ActionResult> LeaveFamily()
        {
            var success = await _service.LeaveFamily(getID());
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