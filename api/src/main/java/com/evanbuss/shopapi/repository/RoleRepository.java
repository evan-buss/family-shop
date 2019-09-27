package com.evanbuss.shopapi.repository;

import com.evanbuss.shopapi.models.Role;
import com.evanbuss.shopapi.models.RoleName;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface RoleRepository extends CrudRepository<Role, Long> {
	Optional<Role> findByName(RoleName roleName);
}
