using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;

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
        [HttpGet]
        public IActionResult GetMembers() {
            return Ok("it works..");
        }

        [HttpPost("create")]
        public IActionResult CreateFamily()
        {
            return Ok();
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
    }
}