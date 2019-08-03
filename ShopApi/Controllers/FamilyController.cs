using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using System.Threading.Tasks;
using System.Collections.Generic;
using System.Security.Claims;
using System;


using ShopApi.Models;
using ShopApi.Models.Private;
using ShopApi.Services;


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

        // // Return all members of the user's family
        // [HttpGet("members")]
        // public IEnumerable<User> GetMembers()
        // {
        //     var memberList = _service.GetMembers(getID());
        //     return memberList;
        // }

        // Return all details of the user's current family
        [HttpGet]
        public ActionResult<Models.Public.Response.Family> GetFamily()
        {
            var family = _service.GetFamily(getID());
            if (family != null)
            {
                return family;
            }
            return BadRequest();
        }

        [HttpPost]
        public async Task<IActionResult> CreateFamily([FromBody] string name)
        {
            Console.WriteLine("New Family Name: " + name);
            var success = await _service.CreateFamily(getID(), name);
            if (success)
            {
                return Ok();
            }

            return BadRequest();
        }

        // [HttpPut("join/{id}")]
        // public IActionResult JoinFamily(long id)
        // {
        //     return Ok(id);
        // }

        // [HttpPut("leave/{id}")]
        // public IActionResult LeaveFamily(long id)
        // {
        //     return Ok(id);
        // }

        // [HttpPut("transfer")]
        // public IActionResult TransferAdmin([FromBody] long userID)
        // {
        //     return Ok(userID);
        // }

        private string getID()
        {
            return User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        }
    }
}