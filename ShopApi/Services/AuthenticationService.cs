using ShopApi.Models;
using System.Linq;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Security.Cryptography;
using Microsoft.IdentityModel.Tokens;
using Microsoft.AspNetCore.Cryptography.KeyDerivation;
using System.Collections.Generic;
using System.Text;
using System;
using ShopApi.Helpers;

namespace ShopApi.Services
{
    public class AuthenticationService
    {   
        private readonly FamilyShopContext _context;

        public AuthenticationService(FamilyShopContext context) 
        {
            _context = context;
        }
        

        // Make sure the given password meets password criteria
        public bool validPassword(string password)
        {
            if (password.Length <= 6)
            {
                return false;
            }
            return true;
        }

        // Check to make sure no other account is using the email address
        public bool emailAvailable(string email)
        {
            if (_context.Users.Where(q => q.email == email).FirstOrDefault() == null)
            {
                return true;
            }
            return false;
        }

        // Generate a unique salt
        public byte[] generateSalt()
        {
            byte[] salt = new byte[128 / 8];
            new RNGCryptoServiceProvider().GetBytes(salt);
            return salt;
        }

        // Generate a securely hashed password using a salt
        public string hashPassword(byte[] salt, string password)
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
        public string GenerateToken(string identifier)
        {
            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes(AppSettings.Secret);
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new Claim[]
                {
                    new Claim(ClaimTypes.NameIdentifier, identifier)
                }),
                Expires = DateTime.UtcNow.AddDays(7),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
            };
            var token = tokenHandler.CreateToken(tokenDescriptor);
            return tokenHandler.WriteToken(token);
        }
    }
}