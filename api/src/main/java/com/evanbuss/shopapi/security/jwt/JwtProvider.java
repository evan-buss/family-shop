package com.evanbuss.shopapi.security.jwt;

import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.InvalidClaimException;
import com.auth0.jwt.exceptions.JWTVerificationException;
import com.auth0.jwt.exceptions.SignatureVerificationException;
import com.auth0.jwt.exceptions.TokenExpiredException;
import com.auth0.jwt.interfaces.DecodedJWT;
import com.evanbuss.shopapi.models.User;
import com.evanbuss.shopapi.security.UserPrinciple;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.datetime.joda.DateTimeParser;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Component;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;

@Component
public class JwtProvider {

  private static final Logger logger = LoggerFactory.getLogger(JwtProvider.class);

  @Value("${evanbuss.app.jwtSecret}")
  private String jwtSecret;

  @Value("${evanbuss.app.jwtExpiration}")
  private int jwtExpiration;

  //  Generate token via authentication object (Used for sign-ins)
  public String generateJwtToken(Authentication authentication) {
    UserPrinciple userPrinciple = (UserPrinciple) authentication.getPrincipal();

    return JWT.create()
        .withSubject(userPrinciple.getEmail())
        .withIssuedAt(new Date())
        .withExpiresAt(new Date((new Date().getTime() + jwtExpiration)))
        .sign(Algorithm.HMAC256(jwtSecret));
  }

  //  Generate token via User object (Used for sign-ups)
  public String generateJWTToken(User user) {
    return JWT.create()
        .withSubject(user.getEmail())
        .withIssuedAt(new Date())
        .withExpiresAt(new Date(new Date().getTime() + jwtExpiration))
        .sign(Algorithm.HMAC256(jwtSecret));
  }

  String getEmailFromJwtToken(String token) {
    return JWT.decode(token).getSubject();
  }

  boolean validateJwtToken(String token) {
    try {
      JWTVerifier verifier = JWT.require(Algorithm.HMAC256(jwtSecret)).build();
      DecodedJWT jwt = verifier.verify(token);
      return true;
    } catch (SignatureVerificationException e) {
      logger.error("Invalid token signature");
    } catch (TokenExpiredException e) {
      logger.error("Token expired!");
    } catch (InvalidClaimException e) {
      logger.error("Invalid token claim");
    } catch (JWTVerificationException e) {
      logger.error("Some token error");
    }

    return false;
  }
}
