package com.evanbuss.shopapi.repository;

import com.evanbuss.shopapi.models.Family;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface FamilyRepository extends CrudRepository<Family, Long> {
  Optional<Family> findByOwnerId(Long id);
}
