package com.evanbuss.shopapi.message.request.item;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

public class UpdateItemRequest {
  @NotNull
  private Long itemID;
  @NotNull
  private Long listID;
  @NotBlank
  private String name;
  private String description;
  private byte[] image;

  public Long getItemID() {
    return itemID;
  }

  public void setItemID(Long itemID) {
    this.itemID = itemID;
  }

  public void setListID(Long listID) {
    this.listID = listID;
  }

  public Long getListID() {
    return listID;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public String getDescription() {
    return description;
  }

  public void setDescription(String description) {
    this.description = description;
  }

  public byte[] getImage() {
    return image;
  }

  public void setImage(byte[] image) {
    this.image = image;
  }
}
