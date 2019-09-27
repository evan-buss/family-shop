package com.evanbuss.shopapi.controller;

import com.evanbuss.shopapi.ResponseError;
import com.evanbuss.shopapi.message.request.family.CreateFamilyRequest;
import com.evanbuss.shopapi.models.Family;
import com.evanbuss.shopapi.models.User;
import com.evanbuss.shopapi.repository.FamilyRepository;
import com.evanbuss.shopapi.repository.UserRepository;
import com.evanbuss.shopapi.security.UserPrinciple;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/family")
public class FamilyController {

  private FamilyRepository familyRepository;
  private UserRepository userRepository;

  @Autowired
  public FamilyController(FamilyRepository familyRepository, UserRepository userRepository) {
    this.familyRepository = familyRepository;
    this.userRepository = userRepository;
  }

  // Return all family info
  @GetMapping("/")
  public ResponseEntity<?> getFamily(Authentication authentication) {
    User user = ((UserPrinciple) authentication.getPrincipal()).getUser();

    if (user.getFamily() == null) {
      return ResponseEntity.badRequest().body(ResponseError.NO_FAMILY);
    }

    Optional<Family> family = familyRepository.findById(user.getFamily().getId());
    if (family.isEmpty()) {
      return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
    }
    return ResponseEntity.ok(family.get());
  }

  // Return list of user objects;
  @GetMapping("/users")
  public ResponseEntity<?> getUsers(Authentication authentication) {
    User user = ((UserPrinciple) authentication.getPrincipal()).getUser();

    if (user.getFamily() == null) {
      return ResponseEntity.badRequest().body(ResponseError.NO_FAMILY);
    }

    List<User> familyMembers = userRepository.findAllByFamilyId(user.getFamily().getId());
    if (familyMembers == null) {
      return ResponseEntity.badRequest().body(ResponseError.NO_FAMILY);
    }
    return ResponseEntity.ok(familyMembers);
  }

  // FIXME: Only for testing purposes
  @GetMapping("/meta")
  public String getMeta(Authentication authentication) {
    Long id = ((UserPrinciple) authentication.getPrincipal()).getId();
    Optional<Family> user = familyRepository.findByOwnerId(id);
    if (user.isPresent()) {
      return user.get().getOwner().getEmail();
    }
    return "Error;";
  }

  @PostMapping("/")
  public ResponseEntity<?> createFamily(
      @RequestBody CreateFamilyRequest request, Authentication authentication) {
    //  Get the user object from the auth system
    User user = ((UserPrinciple) authentication.getPrincipal()).getUser();
    // Create a new family from the request
    Family family = new Family(request.getName(), user);
    // Save the family to the repository
    familyRepository.save(family);
    user.setFamily(family);
    userRepository.save(user);

    return ResponseEntity.status(HttpStatus.CREATED).build();
  }

  @PutMapping("/{familyID}")
  public ResponseEntity<?> joinFamily(
      @PathVariable String familyID, Authentication authentication) {
    User user = ((UserPrinciple) authentication.getPrincipal()).getUser();
    Optional<Family> family = familyRepository.findById(Long.parseLong(familyID));

    if (family.isEmpty()) {
      return ResponseEntity.badRequest().body(ResponseError.NO_FAMILY);
    }

    user.setFamily(family.get());
    userRepository.save(user);

    return ResponseEntity.ok().build();
  }

  @DeleteMapping("/")
  // @PreAuthorize("hasRole('OWNER')")
  public ResponseEntity<?> deleteFamily(Authentication authentication) {
    User user = ((UserPrinciple) authentication.getPrincipal()).getUser();
    user.setFamily(null);
    userRepository.save(user);
    return ResponseEntity.ok().build();
  }
}
