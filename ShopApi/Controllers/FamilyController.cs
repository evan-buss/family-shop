using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using System.Threading.Tasks;
using System.Collections.Generic;
using System.Security.Claims;
using System;


using ShopApi.Models;
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

        // Return all members of the user's family
        [HttpGet("members")]
        public IEnumerable<User> GetMembers()
        {
            var email = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
            var memberList = _service.GetMembers(email);
            return memberList;
        }

        [HttpGet]
        public ActionResult<Family> GetFamily()
        {
            Console.WriteLine("EMAIL: " + User.FindFirst(ClaimTypes.NameIdentifier)?.Value);
            var family = _service.GetFamily(User.FindFirst(ClaimTypes.NameIdentifier)?.Value);
            if (family != null)
            {  
                Console.WriteLine("RETURNING FAMILY");
                return family;
            }

            Console.WriteLine("FAMILY IS NULL");
            return BadRequest();
        }

        [HttpPost]
        public async Task<IActionResult> CreateFamily([FromBody] string name)
        {
            var success = await _service.CreateFamily(getEmail(), name);
            if (success)
            {
                return Ok();
            }

            return BadRequest();
        }

        [HttpPut("join/{id}")]
        public IActionResult JoinFamily(long id)
        {
            return Ok(id);
        }

        [HttpPut("leave/{id}")]
        public IActionResult LeaveFamily(long id)
        {
            return Ok(id);
        }

        [HttpPut("transfer")]
        public IActionResult TransferAdmin([FromBody] long userID)
        {
            return Ok(userID);
        }

        private string getEmail()
        {
            return User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        }
    }
}