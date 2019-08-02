using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;
using ShopApi.Models.Private;
using ShopApi.Models;
using ShopApi.Services;
using System;
using System.Linq;

namespace ShopApi.Controllers
{

    // Controls user sign-ups and log-ins
    public class AuthenticationController : ControllerBase
    {
        private readonly FamilyShopContext _context;
        private readonly AuthenticationService _authService;

        public AuthenticationController(FamilyShopContext context)
        {
            _context = context;
            _authService = new AuthenticationService(_context);
        }

        // Login to an existing account
        [Route("/signin")]
        [HttpPost]
        public IActionResult SignIn(string email, string password)
        {
            Console.WriteLine("email: " + email + "  pass: " + password);
            // Search for the given email in the Users table
            var user = _context.Users.Where(q => q.email == email).FirstOrDefault();
            if (user == null)
            {
                return BadRequest("Invalid email or password");
            }
            if (_authService.hashPassword(user.passwordSalt, password) == user.passwordHash)
            {
                return new ObjectResult(_authService.GenerateToken(user.userID.ToString()));
            }
            return BadRequest("Invalid username or password.");
        }

        // [Route("/logout")]
        // [HttpPost]
        // public IActionResult Logout(string token)
        // {
        //     return BadRequest();
        // }

        [Route("/signup")]
        [HttpPost]
        public async Task<IActionResult> SignUp(string username, string password, string email)
        {

            Console.WriteLine("user: " + username + "  pass: " + password + " email: " + email);
            // 1. Ensure email isn't used
            if (!_authService.emailAvailable(email))
            {
                return BadRequest("Account with username already exists.");
            }
            // 2. Ensure password meets guidelines
            if (!_authService.validPassword(password))
            {
                return BadRequest("Passwords must be atleast 6 characters.");
            }
            // 3. Generate password salt.
            var salt = _authService.generateSalt();
            // 4. Hash salt+password
            var hashedPassword = _authService.hashPassword(salt, password);

            // 5. Store both in the database
            var newUser = new User()
            {
                username = username,
                email = email,
                passwordSalt = salt,
                passwordHash = hashedPassword,
                familyID = 1
            };
            _context.Add(newUser);
            await _context.SaveChangesAsync();
            // 6. Return new valid JWT
            return new ObjectResult(_authService.GenerateToken(newUser.userID.ToString()));
        }
    }
}