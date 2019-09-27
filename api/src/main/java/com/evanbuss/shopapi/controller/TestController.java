package com.evanbuss.shopapi.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TestController {

  @GetMapping("/api/test/member")
  @PreAuthorize("hasRole('MEMBER') or hasRole('OWNER')")
  public String userAccess() {
    return "You have access to member level routes";
  }

  @GetMapping("/api/test/owner")
  @PreAuthorize("hasRole('OWNER')")
  public String adminAccess() {
    return "You have admin access :)";
  }

  @GetMapping("/api/test")
  public String noAuth() { return "test"; }
}
