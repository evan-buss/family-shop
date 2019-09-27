package com.evanbuss.shopapi.repository;

import com.evanbuss.shopapi.models.Item;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ItemRepository extends CrudRepository<Item, Long> {
  Optional<Item> getItemByListIdAndId(Long listId, Long itemId);

  List<Item> getAllByListId(Long listId);
}
