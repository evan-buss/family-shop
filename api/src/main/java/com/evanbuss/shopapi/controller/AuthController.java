package com.evanbuss.shopapi.controller;

import com.evanbuss.shopapi.message.request.auth.LoginRequest;
import com.evanbuss.shopapi.message.request.auth.SignUpRequest;
import com.evanbuss.shopapi.message.response.auth.SuccessfulAuth;
import com.evanbuss.shopapi.models.Role;
import com.evanbuss.shopapi.models.RoleName;
import com.evanbuss.shopapi.models.User;
import com.evanbuss.shopapi.repository.RoleRepository;
import com.evanbuss.shopapi.repository.UserRepository;
import com.evanbuss.shopapi.security.UserPrinciple;
import com.evanbuss.shopapi.security.jwt.JwtProvider;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.HashSet;
import java.util.Set;

@RestController
@RequestMapping("/api/auth")
public class AuthController {

  private final AuthenticationManager authenticationManager;
  private final UserRepository userRepository;
  private final RoleRepository roleRepository;
  private final PasswordEncoder encoder;
  private final JwtProvider jwtProvider;

  @Autowired
  public AuthController(
      AuthenticationManager authenticationManager,
      UserRepository userRepository,
      RoleRepository roleRepository,
      PasswordEncoder encoder,
      JwtProvider jwtProvider) {
    this.authenticationManager = authenticationManager;
    this.userRepository = userRepository;
    this.roleRepository = roleRepository;
    this.encoder = encoder;
    this.jwtProvider = jwtProvider;
  }

  @PostMapping("/signin")
  public ResponseEntity<?> authenticateUser(@Valid @RequestBody LoginRequest request) {

    Authentication authentication =
        authenticationManager.authenticate(
            new UsernamePasswordAuthenticationToken(request.getEmail(), request.getPassword()));

    SecurityContextHolder.getContext().setAuthentication(authentication);

    User user = ((UserPrinciple) authentication.getPrincipal()).getUser();

    String token = jwtProvider.generateJwtToken(authentication);
    return ResponseEntity.ok(new SuccessfulAuth(user.getId(), token, user.getUsername()));
  }

  @PostMapping("/signup")
  public ResponseEntity<?> registerUser(@Valid @RequestBody SignUpRequest signUpRequest) {

    if (userRepository.existsByEmail(signUpRequest.getEmail())) {
      return new ResponseEntity<>("Fail -> Email is already in use!", HttpStatus.BAD_REQUEST);
    }

    // Creating user's account
    User user =
        new User(
            signUpRequest.getUsername(),
            signUpRequest.getEmail(),
            encoder.encode(signUpRequest.getPassword()));

    Set<String> strRoles = signUpRequest.getRole();
    Set<Role> roles = new HashSet<>();

    strRoles.forEach(
        role -> {
          switch (role) {
            case "owner":
              Role pmRole =
                  roleRepository
                      .findByName(RoleName.ROLE_OWNER)
                      .orElseThrow(
                          () -> new RuntimeException("Fail! -> Cause: User Role not find."));
              roles.add(pmRole);

              break;
            case "member":
            default:
              Role userRole =
                  roleRepository
                      .findByName(RoleName.ROLE_MEMBER)
                      .orElseThrow(
                          () -> new RuntimeException("Fail! -> Cause: User Role not find."));
              roles.add(userRole);
          }
        });

    user.setRoles(roles);
    userRepository.save(user);

    String token = jwtProvider.generateJWTToken(user);

    return ResponseEntity.ok(new SuccessfulAuth(user.getId(), token, user.getUsername()));
  }

  @GetMapping("/ping")
  public ResponseEntity<?> pingServer() {
    return ResponseEntity.ok("JWT token is valid");
  }
}
