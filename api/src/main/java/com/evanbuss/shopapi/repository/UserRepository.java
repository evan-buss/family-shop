package com.evanbuss.shopapi.repository;

import com.evanbuss.shopapi.models.User;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends CrudRepository<User, Long> {
  Optional<User> findByEmail(String email);
  // Return all users belonging to a specific family.
  List<User> findAllByFamilyId(Long familyId);

  Boolean existsByEmail(String email);
}
