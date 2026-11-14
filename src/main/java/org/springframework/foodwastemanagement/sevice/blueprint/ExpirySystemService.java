package org.springframework.foodwastemanagement.sevice.blueprint;

import org.springframework.foodwastemanagement.entity.Inventory;

import java.util.List;

public interface ExpirySystemService {

    List<Inventory> getCriticalExpiryData();

    List<Inventory> getPrioritizedItemsList();

    List<Inventory> getAllData();

    List<Integer> getCounts(List<Inventory> allItems);
}
