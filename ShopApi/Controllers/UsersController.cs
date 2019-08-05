using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using Microsoft.AspNetCore.Authorization;
using System.Security.Claims;

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

        [HttpGet("{userID}")]
        public ActionResult<List<Models.Public.Response.User>> GetSpecificUser(long userID)
        {
            return Ok();
        }

        [HttpGet("/whoami")]
        public ActionResult<Models.Public.Response.User> WhoAmI()
        {
            var user = _context.Users.Find(getID());
            return new ObjectResult(user.ToPublic());
        }

        private string getID()
        {
            return User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        }
    }
}