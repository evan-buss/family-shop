package com.evanbuss.shopapi;

import com.evanbuss.shopapi.models.Role;
import com.evanbuss.shopapi.models.RoleName;
import com.evanbuss.shopapi.repository.RoleRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Configuration;

//@Configuration
public class Runner implements CommandLineRunner {

  private static final Logger logger = LoggerFactory.getLogger(Runner.class);

  @Autowired
  private RoleRepository repository;

//  Save the enums to database on start.
  @Override
  public void run(String... args) throws Exception {
    repository.deleteAll();
    repository.save(new Role(RoleName.ROLE_MEMBER));
    repository.save(new Role(RoleName.ROLE_OWNER));
  }
}
