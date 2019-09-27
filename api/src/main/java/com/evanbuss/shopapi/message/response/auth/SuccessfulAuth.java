package com.evanbuss.shopapi.message.response.auth;

public class SuccessfulAuth {

  private Long id;
  private String username;
  private String token;

  public SuccessfulAuth(Long id, String token, String username) {
    this.id = id;
    this.username = username;
    this.token = token;
  }

  public Long getId() {
    return id;
  }

  public void setId(Long id) {
    this.id = id;
  }

  public String getUsername() {
    return username;
  }

  public void setUsername(String username) {
    this.username = username;
  }

  public String getToken() {
    return token;
  }

  public void setToken(String token) {
    this.token = token;
  }
}
