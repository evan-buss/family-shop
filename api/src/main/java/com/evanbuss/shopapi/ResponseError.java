package com.evanbuss.shopapi;

/**
 * ResponseError consists of response messages for common server errors
 */
public final class ResponseError {
  public static final String NO_FAMILY = "You must be a member of a family to perform this action.";
  public static final Object LIST_NOT_FOUND = "Could not find the requested list";
  public static final Object ITEM_NOT_FOUND = "Could not find the requested item";
}
