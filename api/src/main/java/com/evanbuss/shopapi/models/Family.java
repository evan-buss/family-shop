package com.evanbuss.shopapi.models;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import javax.persistence.*;
import java.util.ArrayList;

@Entity
public class Family {

  @Id
  @GeneratedValue(strategy = GenerationType.AUTO)
  private Long id;

  private String name;

  @JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
  @OneToOne(fetch = FetchType.EAGER, optional = false)
  @JoinColumn(name = "user_id", nullable = false)
  private User owner;

  @JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
  @OneToMany(mappedBy = "family", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
  private java.util.List<List> lists = new ArrayList<>();

  //  Default constructor for hibernate
  public Family() {}

  public Family(String name, User owner) {
    this.name = name;
    this.owner = owner;
  }

  public Long getId() {
    return id;
  }

  public void setId(Long id) {
    this.id = id;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public User getOwner() {
    return owner;
  }

  public void setOwner(User owner) {
    this.owner = owner;
  }

  public java.util.List<List> getLists() {
    return lists;
  }

  public void setLists(java.util.List<List> lists) {
    this.lists = lists;
  }
}
