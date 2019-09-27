package com.evanbuss.shopapi.repository;

import com.evanbuss.shopapi.models.List;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ListRepository extends CrudRepository<List, Long> {
  java.util.List<List> getListsByFamilyId(Long familyId);
}
