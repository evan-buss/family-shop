using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using Microsoft.AspNetCore.Authorization;
using System.Security.Claims;
using System;

using ShopApi.Models;

namespace ShopApi.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    public class UsersController : ControllerBase
    {
        private readonly FamilyShopContext _context;

        public UsersController(FamilyShopContext context)
        {
            _context = context;
        }

        // FUTURE API:
        //  - Allow searching for users by 
        //      - Email
        //      - Username

        [HttpGet]
        public ActionResult<Models.Public.Response.User> WhoAmI()
        {
            var user = _context.Users.Find(getID());
            if (user != null)
            {
                Console.WriteLine(user.username);
                return user.ToPublic();
            }
            return NotFound();
        }

        // TODO: Implement user searching
        [HttpGet("{userID}")]
        public ActionResult<List<Models.Public.Response.User>> GetSpecificUser(long userID)
        {
            return BadRequest();
        }

        private long getID()
        {
            return long.Parse(User.FindFirst(ClaimTypes.NameIdentifier)?.Value);
        }
    }
}