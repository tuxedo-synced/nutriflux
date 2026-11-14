package org.springframework.foodwastemanagement.sevice.blueprint;

import org.springframework.foodwastemanagement.entity.Inventory;

public interface ApiService {

    Inventory incrementQuantity(String barcode);
}
