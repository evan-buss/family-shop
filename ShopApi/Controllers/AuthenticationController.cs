using System;
using System.Text;
using Microsoft.AspNetCore.Mvc;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Threading.Tasks;
using Microsoft.IdentityModel.Tokens;
using Microsoft.AspNetCore.Cryptography.KeyDerivation;
using System.Collections.Generic;
using System.Linq;

using ShopApi.Models;

namespace ShopApi.Controllers
{

    public class AuthenticationController : ControllerBase
    {

        private readonly FamilyShopContext _context;

        public AuthenticationController(FamilyShopContext context)
        {
            _context = context;
        }

        // Login to an existing account
        [Route("/signin")]
        [HttpPost]
        public IActionResult SignIn(string email, string password)
        {
            var user = _context.Users.Find(email);
            if (user == null)
            {
                return BadRequest("Invalid email or password");
            }
            var savedPasswordhash = hashPassword(user.passwordSalt, password);
            Console.WriteLine("GEN: " + savedPasswordhash + "  SAVED: " + user.passwordHash);
            if (savedPasswordhash == user.passwordHash)
            {
                return new ObjectResult(GenerateToken(email));
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

            // 1. Ensure email isn't used
            if (!emailAvailable(email))
            {
                return BadRequest("Account with username already exists.");
            }
            // 2. Ensure password meets guidelines
            if (!validPassword(password))
            {
                return BadRequest("Passwords must be atleast 6 characters.");
            }
            // 3. Generate password salt.
            var salt = generateSalt();
            // 4. Hash salt+password
            var hashedPassword = hashPassword(salt, password);
            // 5. Store both in the database
            // 6. Return new valid JWT
            var newUser = new User()
            {
                username = username,
                email = email,
                passwordSalt = salt,
                passwordHash = hashedPassword
            };
            _context.Add(newUser);
            await _context.SaveChangesAsync();
            return new ObjectResult(GenerateToken(email));
        }

        // Make sure the given password meets password criteria
        private bool validPassword(string password)
        {
            if (password.Length <= 6)
            {
                return false;
            }
            return true;
        }

        // Check to make sure no other account is using the email address
        private bool emailAvailable(string email)
        {
            if (_context.Users.Where(q => q.email == email).FirstOrDefault() == null)
            {
                return true;
            }
            return false;
        }

        // Generate a unique salt
        private byte[] generateSalt()
        {
            byte[] salt = new byte[128 / 8];
            new RNGCryptoServiceProvider().GetBytes(salt);
            return salt;
        }

        // Generate a securely hashed password
        private string hashPassword(byte[] salt, string password)
        {
            // derive a 256-bit subkey (use HMACSHA1 with 10,000 iterations)
            string hashed = Convert.ToBase64String(KeyDerivation.Pbkdf2(
                password: password,
                salt: salt,
                prf: KeyDerivationPrf.HMACSHA1,
                iterationCount: 10000,
                numBytesRequested: 256 / 8));
            return hashed;
        }

        // Generate a JWT token...
        private string GenerateToken(string username)
        {
            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes("the secret that needs to be at least 16 characters long for HmacSha256bytes");
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new Claim[]
                {
                    new Claim(ClaimTypes.NameIdentifier, username)
                }),
                Expires = DateTime.UtcNow.AddMinutes(1),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
            };
            var token = tokenHandler.CreateToken(tokenDescriptor);
            return tokenHandler.WriteToken(token);
        }
    }
}